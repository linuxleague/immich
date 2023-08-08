import { Inject, Injectable, Logger } from '@nestjs/common';
import axios from 'axios';
import { ISystemConfigRepository } from '.';
import { ICryptoRepository } from '../crypto/crypto.repository';
import { ServerVersion, serverVersion } from '../domain.constant';
import { GithubRelease, IJobRepository, JobName } from '../job';
import { UserCore } from '../user/user.core';
import { IUserRepository } from '../user/user.repository';
import { mapConfig, SystemConfigDto } from './dto/system-config.dto';
import { SystemConfigTemplateStorageOptionDto } from './response-dto/system-config-template-storage-option.dto';
import {
  supportedDayTokens,
  supportedHourTokens,
  supportedMinuteTokens,
  supportedMonthTokens,
  supportedPresetTokens,
  supportedSecondTokens,
  supportedYearTokens,
} from './system-config.constants';
import { SystemConfigCore, SystemConfigValidator } from './system-config.core';

@Injectable()
export class SystemConfigService {
  private core: SystemConfigCore;
  public availableVersion: ServerVersion | null;
  private userCore: UserCore;
  private proxyHost: string | null;
  private proxyProtocol: string | null;
  private proxyPort: number | null;
  private disableCheckLatestVersion: boolean;

  private logger = new Logger();

  constructor(
    @Inject(IUserRepository) userRepository: IUserRepository,
    @Inject(ICryptoRepository) cryptoRepository: ICryptoRepository,

    @Inject(ISystemConfigRepository) repository: ISystemConfigRepository,
    @Inject(IJobRepository) private jobRepository: IJobRepository,
  ) {
    this.availableVersion = null;
    this.userCore = new UserCore(userRepository, cryptoRepository);
    this.core = new SystemConfigCore(repository);
    this.proxyHost = process.env.PROXY_HOST || null;
    this.proxyProtocol = process.env.PROXY_PROTOCOL || null;
    this.proxyPort = Number(process.env.PROXY_PORT) || null;
    this.disableCheckLatestVersion = Boolean(process.env.DISABLE_CHECK_LATEST_VERSION) || false;
  }

  get config$() {
    return this.core.config$;
  }

  async getConfig(): Promise<SystemConfigDto> {
    const config = await this.core.getConfig();
    return mapConfig(config);
  }

  getDefaults(): SystemConfigDto {
    const config = this.core.getDefaults();
    return mapConfig(config);
  }

  getLatestVersion(): SystemConfigDto {
    const config = this.core.getDefaults();
    return mapConfig(config);
  }

  async updateConfig(dto: SystemConfigDto): Promise<SystemConfigDto> {
    const config = await this.core.updateConfig(dto);
    await this.jobRepository.queue({ name: JobName.SYSTEM_CONFIG_CHANGE });
    return mapConfig(config);
  }

  async refreshConfig() {
    await this.core.refreshConfig();
    return true;
  }

  addValidator(validator: SystemConfigValidator) {
    this.core.addValidator(validator);
  }

  async handleImmichLatestVersionAvailable() {
    const proxy =
      this.proxyHost && this.proxyPort && this.proxyProtocol
        ? {
            protocol: this.proxyProtocol,
            port: this.proxyPort,
            host: this.proxyHost,
          }
        : false;

    if (this.disableCheckLatestVersion) {
      return true;
    }
    try {
      const { data } = await axios.get<GithubRelease>(
        'https://api.github.com/repos/immich-app/immich/releases/latest',
        {
          headers: {
            Accept: 'application/vnd.github.v3+json',
          },
          proxy,
        },
      );

      const [, major, minor, patch] = data.tag_name.match(/v(\d+)\.(\d+)\.(\d+)/) || [];

      const temp = new ServerVersion(major, minor, patch);

      if (temp.toString().localeCompare(serverVersion.toString(), undefined, { numeric: true }) === 1) {
        this.logger.debug(`New version detected : ${temp.toString()}`);

        const users = await this.userCore.getList();
        console.log(temp);
        console.log(this.availableVersion);
        if (this.availableVersion) {
          if (temp.toString() !== this.availableVersion.toString()) {
            for (const user of users) {
              if (user.isAdmin) {
                await this.userCore.updateUser(user, user.id, user);
              }
            }
          }
        }

        this.availableVersion = temp;
      } else {
        this.logger.debug('No new version detected');
      }

      return true;
    } catch (error) {
      console.error('Error occurred:', error);
      return false;
    }
  }

  getStorageTemplateOptions(): SystemConfigTemplateStorageOptionDto {
    const options = new SystemConfigTemplateStorageOptionDto();

    options.dayOptions = supportedDayTokens;
    options.monthOptions = supportedMonthTokens;
    options.yearOptions = supportedYearTokens;
    options.hourOptions = supportedHourTokens;
    options.secondOptions = supportedSecondTokens;
    options.minuteOptions = supportedMinuteTokens;
    options.presetOptions = supportedPresetTokens;

    return options;
  }
}
