{ den, inputs, ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nfsm-flake = {
      url = "github:gvolpe/nfsm";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  den.aspects.niri = {
    includes = [
      den.aspects.niri._.keybinds
      den.aspects.niri._.window-rules
      den.aspects.niri._.idle
    ];

    nixos = { pkgs, ... }: {
      imports = [
        inputs.niri.nixosModules.niri
      ];

      nixpkgs.overlays = [ inputs.niri.overlays.niri ];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };
      services.gnome.gnome-keyring.enable = true;

    };

    homeManager = { config, lib, pkgs, osConfig, ... }:
      {
        imports = [
          inputs.nfsm-flake.homeModules.default
          inputs.noctalia.homeModules.default
          ../_hypridle.nix
        ];

        home.packages = [
          pkgs.brightnessctl
          pkgs.xwayland-satellite-unstable
          pkgs.gpu-screen-recorder
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.inter
          pkgs.wl-clipboard
          pkgs.satty
          pkgs.polkit_gnome
        ];

        services.gammastep = {
          enable = true;
          enableVerboseLogging = false;
          # provider = "geoclue2";
          provider = "manual";
          dawnTime = "05:30";
          duskTime = "18:00";
          temperature = { day = 6500; night = 3500; };
          settings = {
            general = { adjustment-method = "wayland"; fade = 1; };
            wayland = { output = "*DP-*"; };
          };
        };

        systemd.user.services.nfsm = {
          Unit = {
            PartOf = [ "niri.service" ];
            After = [ "niri.service" ];
            Requires = [ "niri.service" ];
          };
          Install.WantedBy = [ "niri.service" ];
        };

        services.nfsm = {
          enable = true;
        };

        xdg.portal = {
          enable = lib.mkForce true;
          extraPortals = [
            pkgs.xdg-desktop-portal-gtk
            pkgs.xdg-desktop-portal-gnome
            pkgs.gnome-keyring
          ];
          config.niri = {
            default = [ "gnome" "gtk" ];
            "org.freedesktop.impl.portal.Access" = [ "gtk" ];
            "org.freedesktop.impl.portal.Notification" = [ "gtk" ];
            "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
          };
        };

        systemd.user.services.niri-flake-polkit = {
          Install.WantedBy = lib.mkForce [ "niri.service" ];
          Unit = {
            Description = lib.mkForce "PolicyKit Authentication Agent (polkit_gnome)";
            After = lib.mkForce [ "graphical-session.target" ];
            PartOf = lib.mkForce [ "graphical-session.target" ];
          };
          Service = {
            Type = lib.mkForce "simple";
            ExecStart = lib.mkForce "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = lib.mkForce "on-failure";
            RestartSec = lib.mkForce 1;
            TimeoutStopSec = lib.mkForce 10;
          };
        };

        programs.noctalia-shell = {
          enable = true;
          package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
          settings = lib.mkForce {
            appLauncher = {
              autoPasteClipboard = false;
              clipboardWatchImageCommand = "wl-paste --type image --watch cliphist store";
              clipboardWatchTextCommand = "wl-paste --type text --watch cliphist store";
              clipboardWrapText = true;
              customLaunchPrefix = "";
              customLaunchPrefixEnabled = false;
              density = "default";
              enableClipPreview = true;
              enableClipboardChips = true;
              enableClipboardHistory = true;
              enableClipboardSmartIcons = true;
              enableSessionSearch = true;
              enableSettingsSearch = true;
              enableWindowsSearch = true;
              iconMode = "tabler";
              ignoreMouseInput = false;
              overviewLayer = false;
              pinnedApps = [ ];
              position = "center";
              screenshotAnnotationTool = "";
              showCategories = true;
              showIconBackground = true;
              sortByMostUsed = true;
              terminalCommand = "kitty -e";
              viewMode = "list";
            };
            audio = {
              mprisBlacklist = [ ];
              preferredPlayer = "";
              spectrumFrameRate = 60;
              spectrumMirrored = true;
              visualizerType = "linear";
              volumeFeedback = false;
              volumeFeedbackSoundFile = "";
              volumeOverdrive = false;
              volumeStep = 5;
            };
            bar = {
              autoHideDelay = 500;
              autoShowDelay = 150;
              backgroundOpacity = 0.93;
              barType = "simple";
              capsuleColorKey = "none";
              capsuleOpacity = 1;
              contentPadding = 0;
              density = "comfortable";
              displayMode = "always_visible";
              enableExclusionZoneInset = true;
              fontScale = 1;
              frameRadius = 12;
              frameThickness = 8;
              hideOnOverview = false;
              marginHorizontal = 5;
              marginVertical = 5;
              middleClickAction = "none";
              middleClickCommand = "";
              middleClickFollowMouse = false;
              monitors = [ ];
              mouseWheelAction = "none";
              mouseWheelWrap = true;
              outerCorners = false;
              position = "top";
              reverseScroll = false;
              rightClickAction = "controlCenter";
              rightClickCommand = "";
              rightClickFollowMouse = true;
              screenOverrides = [ ];
              showCapsule = true;
              showOnWorkspaceSwitch = true;
              showOutline = false;
              useSeparateOpacity = false;
              widgetSpacing = 6;
              widgets = {
                center = [
                  {
                    defaultSettings = {
                      activeColor = "primary";
                      hideInactive = false;
                      inactiveColor = "none";
                      removeMargins = false;
                    };
                    id = "plugin:privacy-indicator";
                  }
                  {
                    compactMode = false;
                    diskPath = "/home";
                    iconColor = "primary";
                    id = "SystemMonitor";
                    showCpuCores = false;
                    showCpuFreq = false;
                    showCpuTemp = true;
                    showCpuUsage = true;
                    showDiskAvailable = false;
                    showDiskUsage = false;
                    showDiskUsageAsPercent = false;
                    showGpuTemp = false;
                    showLoadAverage = false;
                    showMemoryAsPercent = false;
                    showMemoryUsage = true;
                    showNetworkStats = false;
                    showSwapUsage = true;
                    textColor = "primary";
                    useMonospaceFont = true;
                    usePadding = false;
                  }
                  { id = "Spacer"; width = 20; }
                  {
                    clockColor = "primary";
                    customFont = "";
                    formatHorizontal = "HH:mm:ss ddd, MMM dd";
                    formatVertical = "HH mm ss - dd MM";
                    id = "Clock";
                    tooltipFormat = "HH:mm ddd, MMM dd";
                    useCustomFont = false;
                  }
                  { id = "Spacer"; width = 20; }
                  {
                    blacklist = [ ];
                    chevronColor = "none";
                    colorizeIcons = false;
                    drawerEnabled = true;
                    hidePassive = false;
                    id = "Tray";
                    pinned = [ "Bluetooth Active" "Bluetooth Enabled" ];
                  }
                ];
                left = [
                  {
                    characterCount = 2;
                    colorizeIcons = false;
                    emptyColor = "secondary";
                    enableScrollWheel = true;
                    focusedColor = "primary";
                    followFocusedScreen = false;
                    fontWeight = "bold";
                    groupedBorderOpacity = 1;
                    hideUnoccupied = false;
                    iconScale = 0.8;
                    id = "Workspace";
                    labelMode = "name";
                    occupiedColor = "secondary";
                    pillSize = 0.6;
                    showApplications = false;
                    showApplicationsHover = false;
                    showBadge = true;
                    showLabelsOnlyWhenOccupied = true;
                    unfocusedIconsOpacity = 1;
                  }
                  {
                    compactMode = false;
                    hideMode = "hidden";
                    hideWhenIdle = false;
                    id = "MediaMini";
                    maxWidth = 145;
                    panelShowAlbumArt = true;
                    scrollingMode = "hover";
                    showAlbumArt = false;
                    showArtistFirst = true;
                    showProgressRing = true;
                    showVisualizer = true;
                    textColor = "none";
                    useFixedWidth = false;
                    visualizerType = "linear";
                  }
                  {
                    colorizeIcons = false;
                    hideMode = "hidden";
                    id = "ActiveWindow";
                    maxWidth = 145;
                    scrollingMode = "hover";
                    showIcon = true;
                    showText = true;
                    textColor = "none";
                    useFixedWidth = false;
                  }
                ];
                right = [
                  {
                    displayMode = "onhover";
                    iconColor = "none";
                    id = "Volume";
                    middleClickCommand = "pwvucontrol || pavucontrol";
                    textColor = "none";
                  }
                  {
                    applyToAllMonitors = false;
                    displayMode = "onhover";
                    iconColor = "none";
                    id = "Brightness";
                    textColor = "none";
                  }
                  {
                    displayMode = "onhover";
                    iconColor = "none";
                    id = "Network";
                    textColor = "none";
                  }
                  {
                    displayMode = "onhover";
                    iconColor = "none";
                    id = "Bluetooth";
                    textColor = "none";
                  }
                  {
                    hideWhenZero = true;
                    hideWhenZeroUnread = false;
                    iconColor = "none";
                    id = "NotificationHistory";
                    showUnreadBadge = true;
                    unreadBadgeColor = "primary";
                  }
                  {
                    deviceNativePath = "BAT1";
                    displayMode = "icon-hover";
                    hideIfIdle = false;
                    hideIfNotDetected = true;
                    id = "Battery";
                    showNoctaliaPerformance = true;
                    showPowerProfiles = true;
                  }
                  {
                    defaultSettings = {
                      audioCodec = "opus";
                      audioSource = "default_output";
                      colorRange = "limited";
                      copyToClipboard = false;
                      directory = "";
                      filenamePattern = "recording_yyyyMMdd_HHmmss";
                      frameRate = "60";
                      hideInactive = false;
                      quality = "very_high";
                      resolution = "original";
                      showCursor = true;
                      videoCodec = "h264";
                      videoSource = "portal";
                    };
                    id = "plugin:screen-recorder";
                  }
                  {
                    defaultSettings = {
                      debug = false;
                      rogcc = { listenToNotifications = false; };
                      supergfxctl = {
                        patchPending = true;
                        polling = false;
                        pollingInterval = 3000;
                      };
                    };
                    id = "plugin:noctalia-supergfxctl";
                  }
                  {
                    colorizeDistroLogo = false;
                    colorizeSystemIcon = "none";
                    colorizeSystemText = "none";
                    customIconPath = "";
                    enableColorization = false;
                    icon = "noctalia";
                    id = "ControlCenter";
                    useDistroLogo = false;
                  }
                ];
              };
            };
            brightness = {
              backlightDeviceMappings = [ ];
              brightnessStep = 5;
              enableDdcSupport = false;
              enforceMinimum = true;
            };
            calendar = {
              cards = [
                { enabled = false; id = "calendar-header-card"; }
                { enabled = false; id = "calendar-month-card"; }
                { enabled = true; id = "calendar-header-card"; }
                { enabled = true; id = "calendar-month-card"; }
                { enabled = true; id = "timer-card"; }
                { enabled = true; id = "weather-card"; }
              ];
            };
            colorSchemes = {
              darkMode = true;
              generationMethod = "tonal-spot";
              manualSunrise = "06:30";
              manualSunset = "18:30";
              monitorForColors = "";
              predefinedScheme = "Nord";
              schedulingMode = "off";
              syncGsettings = true;
              useWallpaperColors = true;
            };
            controlCenter = {
              cards = [
                { enabled = true; id = "profile-card"; }
                { enabled = true; id = "shortcuts-card"; }
                { enabled = true; id = "audio-card"; }
                { enabled = false; id = "weather-card"; }
                { enabled = true; id = "media-sysmon-card"; }
                { enabled = false; id = "brightness-card"; }
              ];
              diskPath = "/";
              position = "close_to_bar_button";
              shortcuts = {
                left = [
                  { id = "Network"; }
                  { id = "Bluetooth"; }
                  { id = "WallpaperSelector"; }
                ];
                right = [
                  { id = "Notifications"; }
                  { id = "PowerProfile"; }
                  { id = "KeepAwake"; }
                  { id = "NightLight"; }
                ];
              };
            };
            desktopWidgets = {
              enabled = true;
              gridSnap = false;
              gridSnapScale = false;
              monitorWidgets = [
                {
                  name = "DP-3";
                  widgets = [
                    { id = "Weather"; showBackground = true; x = 100; y = 300; }
                  ];
                }
              ];
              overviewEnabled = true;
            };
            dock = {
              animationSpeed = 1;
              backgroundOpacity = 1;
              colorizeIcons = false;
              deadOpacity = 0.6;
              displayMode = "auto_hide";
              dockType = "floating";
              enabled = false;
              floatingRatio = 1;
              groupApps = false;
              groupClickAction = "cycle";
              groupContextMenuMode = "extended";
              groupIndicatorStyle = "dots";
              inactiveIndicators = true;
              indicatorColor = "primary";
              indicatorOpacity = 0.6;
              indicatorThickness = 3;
              launcherIcon = "";
              launcherIconColor = "none";
              launcherPosition = "end";
              launcherUseDistroLogo = false;
              monitors = [ ];
              onlySameOutput = false;
              pinnedApps = [ ];
              pinnedStatic = true;
              position = "bottom";
              showDockIndicator = false;
              showLauncherIcon = false;
              sitOnFrame = false;
              size = 1;
            };
            general = {
              allowPanelsOnScreenWithoutBar = true;
              allowPasswordWithFprintd = false;
              animationDisabled = false;
              animationSpeed = 1;
              autoStartAuth = false;
              avatarImage = "/home/albertjul/.face";
              boxRadiusRatio = 1;
              clockFormat = "hh\\nmm";
              clockStyle = "custom";
              compactLockScreen = false;
              dimmerOpacity = 0.8;
              enableBlurBehind = true;
              enableLockScreenCountdown = true;
              enableLockScreenMediaControls = false;
              enableShadows = true;
              forceBlackScreenCorners = false;
              iRadiusRatio = 1;
              keybinds = {
                keyDown = [ "Down" ];
                keyEnter = [ "Return" "Enter" ];
                keyEscape = [ "Esc" ];
                keyLeft = [ "Left" ];
                keyRemove = [ "Del" ];
                keyRight = [ "Right" ];
                keyUp = [ "Up" ];
              };
              language = "";
              lockOnSuspend = true;
              lockScreenAnimations = false;
              lockScreenBlur = 0;
              lockScreenCountdownDuration = 10000;
              lockScreenMonitors = [ ];
              lockScreenTint = 0;
              passwordChars = false;
              radiusRatio = 1;
              reverseScroll = false;
              scaleRatio = 1;
              screenRadiusRatio = 1;
              shadowDirection = "bottom_right";
              shadowOffsetX = 2;
              shadowOffsetY = 3;
              showChangelogOnStartup = true;
              showHibernateOnLockScreen = false;
              showScreenCorners = true;
              showSessionButtonsOnLockScreen = true;
              smoothScrollEnabled = true;
              telemetryEnabled = false;
            };
            hooks = {
              colorGeneration = "";
              darkModeChange = "";
              enabled = true;
              performanceModeDisabled = "";
              performanceModeEnabled = "";
              screenLock = "";
              screenUnlock = "";
              session = "";
              startup = "rog-control-center";
              wallpaperChange = "";
            };
            idle = {
              customCommands = "[]";
              enabled = false;
              fadeDuration = 5;
              lockCommand = "";
              lockTimeout = 660;
              resumeLockCommand = "";
              resumeScreenOffCommand = "";
              resumeSuspendCommand = "";
              screenOffCommand = "";
              screenOffTimeout = 600;
              suspendCommand = "";
              suspendTimeout = 1800;
            };
            location = {
              analogClockInCalendar = false;
              autoLocate = false;
              firstDayOfWeek = -1;
              hideWeatherCityName = false;
              hideWeatherTimezone = false;
              name = "Salt Lake City";
              showCalendarEvents = true;
              showCalendarWeather = true;
              showWeekNumberInCalendar = false;
              use12hourFormat = false;
              useFahrenheit = false;
              weatherEnabled = true;
              weatherShowEffects = true;
              weatherTaliaMascotAlways = false;
            };
            network = {
              bluetoothAutoConnect = true;
              bluetoothDetailsViewMode = "grid";
              bluetoothHideUnnamedDevices = false;
              bluetoothRssiPollIntervalMs = 10000;
              bluetoothRssiPollingEnabled = false;
              disableDiscoverability = false;
              networkPanelView = "wifi";
              wifiDetailsViewMode = "grid";
            };
            nightLight = {
              autoSchedule = false;
              dayTemp = "6500";
              enabled = false;
              forced = false;
              manualSunrise = "06:30";
              manualSunset = "18:30";
              nightTemp = "4000";
            };
            noctaliaPerformance = {
              disableDesktopWidgets = true;
              disableWallpaper = true;
            };
            notifications = {
              backgroundOpacity = 1;
              clearDismissed = true;
              criticalUrgencyDuration = 15;
              density = "default";
              enableBatteryToast = true;
              enableKeyboardLayoutToast = true;
              enableMarkdown = false;
              enableMediaToast = false;
              enabled = true;
              location = "top_right";
              lowUrgencyDuration = 3;
              monitors = [ ];
              normalUrgencyDuration = 8;
              overlayLayer = true;
              respectExpireTimeout = true;
              saveToHistory = {
                critical = true;
                low = true;
                normal = true;
              };
              sounds = {
                criticalSoundFile = "";
                enabled = false;
                excludedApps = "discord,firefox,chrome,chromium,edge";
                lowSoundFile = "";
                normalSoundFile = "";
                separateSounds = false;
                volume = 0.5;
              };
            };
            osd = {
              autoHideMs = 2000;
              backgroundOpacity = 1;
              enabled = true;
              enabledTypes = [ 0 1 2 3 ];
              location = "top";
              monitors = [ ];
              overlayLayer = true;
            };
            plugins = {
              autoUpdate = false;
              notifyUpdates = true;
            };
            sessionMenu = {
              countdownDuration = 10000;
              enableCountdown = true;
              largeButtonsLayout = "grid";
              largeButtonsStyle = true;
              position = "center";
              powerOptions = [
                { action = "lock"; command = ""; countdownEnabled = true; enabled = true; keybind = "1"; }
                { action = "suspend"; command = ""; countdownEnabled = true; enabled = true; keybind = "2"; }
                { action = "hibernate"; command = ""; countdownEnabled = true; enabled = true; keybind = "3"; }
                { action = "reboot"; command = ""; countdownEnabled = true; enabled = true; keybind = "4"; }
                { action = "logout"; command = ""; countdownEnabled = true; enabled = true; keybind = "5"; }
                { action = "shutdown"; command = ""; countdownEnabled = true; enabled = true; keybind = "6"; }
                { action = "userspaceReboot"; command = ""; countdownEnabled = true; enabled = false; keybind = ""; }
                { action = "rebootToUefi"; command = ""; countdownEnabled = true; enabled = true; keybind = "7"; }
              ];
              showHeader = true;
              showKeybinds = true;
            };
            systemMonitor = {
              batteryCriticalThreshold = 5;
              batteryWarningThreshold = 20;
              cpuCriticalThreshold = 90;
              cpuWarningThreshold = 80;
              criticalColor = "";
              diskAvailCriticalThreshold = 10;
              diskAvailWarningThreshold = 20;
              diskCriticalThreshold = 90;
              diskWarningThreshold = 80;
              enableDgpuMonitoring = false;
              externalMonitor = "resources || missioncenter || jdsystemmonitor || corestats || system-monitoring-center || gnome-system-monitor || plasma-systemmonitor || mate-system-monitor || ukui-system-monitor || deepin-system-monitor || pantheon-system-monitor";
              gpuCriticalThreshold = 90;
              gpuWarningThreshold = 80;
              memCriticalThreshold = 90;
              memWarningThreshold = 80;
              swapCriticalThreshold = 90;
              swapWarningThreshold = 80;
              tempCriticalThreshold = 90;
              tempWarningThreshold = 80;
              useCustomColors = false;
              warningColor = "";
            };
            templates = {
              activeTemplates = [ ];
              enableUserTheming = false;
            };
            ui = {
              boxBorderEnabled = false;
              fontDefault = "Adwaita Sans";
              fontDefaultScale = 1;
              fontFixed = "Hasklig";
              fontFixedScale = 1;
              panelBackgroundOpacity = 1;
              panelsAttachedToBar = true;
              scrollbarAlwaysVisible = true;
              settingsPanelMode = "centered";
              settingsPanelSideBarCardStyle = false;
              tooltipsEnabled = true;
              translucentWidgets = false;
            };
            wallpaper = {
              automationEnabled = true;
              directory = "/home/albertjul/Pictures/Wallpapers";
              enableMultiMonitorDirectories = false;
              enabled = true;
              favorites = [ ];
              fillColor = "#000000";
              fillMode = "crop";
              hideWallpaperFilenames = false;
              linkLightAndDarkWallpapers = true;
              monitorDirectories = [ ];
              overviewBlur = 0.4;
              overviewEnabled = true;
              overviewTint = 0.6;
              panelPosition = "follow_bar";
              randomIntervalSec = 300;
              setWallpaperOnAllMonitors = true;
              showHiddenFiles = false;
              skipStartupTransition = false;
              solidColor = "#1a1a2e";
              sortOrder = "name";
              transitionDuration = 1500;
              transitionEdgeSmoothness = 0.05;
              transitionType = [ "wipe" ];
              useOriginalImages = false;
              useSolidColor = false;
              useWallhaven = false;
              viewMode = "single";
              wallhavenApiKey = "";
              wallhavenCategories = "111";
              wallhavenOrder = "desc";
              wallhavenPurity = "100";
              wallhavenQuery = "";
              wallhavenRatios = "";
              wallhavenResolutionHeight = "";
              wallhavenResolutionMode = "atleast";
              wallhavenResolutionWidth = "";
              wallhavenSorting = "date_added";
              wallpaperChangeMode = "random";
            };
          };
          colors = lib.mkForce {
            mError = "#ffb4ab";
            mOnError = "#690005";
            mOnPrimary = "#003350";
            mOnSecondary = "#22323f";
            mOnSurface = "#e2e2e5";
            mOnSurfaceVariant = "#c1c7ce";
            mOnTertiary = "#372b4a";
            mOnHover = "#372b4a";
            mOutline = "#42474d";
            mPrimary = "#90cdff";
            mSecondary = "#b8c8d9";
            mShadow = "#000000";
            mSurface = "#111416";
            mHover = "#d0bfe7";
            mSurfaceVariant = "#1e2022";
            mTertiary = "#d0bfe7";
          };
          plugins = {
            sources = [
              {
                enabled = true;
                name = "Noctalia Plugins";
                url = "https://github.com/noctalia-dev/noctalia-plugins";
              }
            ];
            states = {
              noctalia-supergfxctl = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
              privacy-indicator = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
              screen-recorder = {
                enabled = true;
                sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
              };
            };
            version = 2;
          };
        };

        programs.niri.settings = {
          debug = {
            render-drm-device = "/dev/dri/amd-igpu";
            honor-xdg-activation-with-invalid-serial = [ ];
          };

          environment = {
            GDK_BACKEND = "wayland,x11,*";
            SDL_VIDEODRIVER = "wayland,x11";
            CLUTTER_BACKEND = "wayland";
            QT_QPA_PLATFORM = "wayland;xcb";
            QT_AUTO_SCREEN_SCALE_FACTOR = "1";
            QT_QPA_PLATFORMTHEME = "qt5ct";
            ELECTRON_OZONE_PLATFORM_HINT = "auto";
          };

          spawn-at-startup = [
            { command = [ "noctalia-shell" ]; }
          ];

          input = {
            keyboard = { xkb.layout = "us"; };
            touchpad = { enable = true; tap = true; dwt = true; natural-scroll = true; };
            mouse = { enable = true; };
            trackpoint = { enable = true; };
            touch = { map-to-output = "eDP-1"; };
            tablet = { enable = true; map-to-output = "eDP-1"; };
            focus-follows-mouse = { enable = true; max-scroll-amount = "0%"; };
          };

          outputs = {
            "eDP-1" = {
              enable = true;
              scale = 2.0;
              mode = { width = 3840; height = 2400; refresh = 60.00; };
              position = { x = 1920; y = 0; };
            };
            "ASUSTek COMPUTER INC VG278 M3LMQS154329" = {
              enable = true;
              variable-refresh-rate = "on-demand";
              scale = 1.0;
              mode = { width = 1920; height = 1080; refresh = 164.917; };
              position = { x = 0; y = 0; };
            };
          };

          layout = {
            gaps = 10;
            background-color = "transparent";
            focus-ring = { enable = true; width = 2; };
            border = { enable = true; width = 2; };
            struts = { left = 10; right = 10; top = 0; bottom = 2; };
            tab-indicator = { place-within-column = true; };
          };

          workspaces = {
            "media" = { open-on-output = "eDP-1"; };
            "work-monitor" = {
              open-on-output = "ASUSTek COMPUTER INC VG278 M3LMQS154329";
            };
            "work-secondary" = { open-on-output = "eDP-1"; };
          };

          animations = { enable = true; slowdown = 0.9; };
          clipboard.disable-primary = true;
          cursor.hide-when-typing = true;
          hotkey-overlay.skip-at-startup = true;
        };
      };
  };
}
