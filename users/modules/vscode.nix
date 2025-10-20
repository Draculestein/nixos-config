{ config, lib, pkgs, ... }:
{
  programs.vscode = {
    enable = true;
    profiles.default.enableUpdateCheck = false;
    mutableExtensionsDir = true;

    profiles.default.userSettings = {
      "editor.fontFamily" = "'Hasklug Nerd Font', 'monospace', monospace";
      "editor.tabSize" = 2;
      "editor.defaultFormatter" = "esbenp.prettier-vscode";
      "editor.inlineSuggest.suppressSuggestions" = true;
      "editor.accessibilitySupport" = "off";
      "workbench.iconTheme" = "catppuccin-macchiato";
      "workbench.startupEditor" = "welcomePage";
      "window.restoreWindows" = "none";

      "git.confirmSync" = false;
      "git.autofetch" = true;
      "git.enableSmartCommit" = true;

      "prettier.printWidth" = 100;
      "prettier.singleQuote" = true;
      "prettier.tabWidth" = 2;
      "prettier.useTabs" = false;

      "nix.enableLanguageServer" = true;
      "nix.formatterPath" = "nixpkgs-fmt";
      "nix.serverPath" = "nixd";
      "nix.serverSettings" = {
        "nixd" = {
          "formatting" = {
            "command" = [ "nixpkgs-fmt" ];
          };
          "options" = {
            "nixos" = {
              "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").nixosConfigurations.AlbertProP16.options";
            };
            "home-manager" = {
              "expr" = "(builtins.getFlake \"/home/albertjul/.dotfiles/flake.nix\").homeConfigurations.albertjul.options";
            };
          };
        };
      };

      # Language formatter settings
      "[dockerfile]" = {
        "editor.defaultFormatter" = "ms-azuretools.vscode-containers";
      };
      "[nix]" = {
        "editor.defaultFormatter" = "jnoortheen.nix-ide";
      };
      "[erb]" = {
        "editor.defaultFormatter" = "Shopify.ruby-lsp";
      };
      "[toml]" = {
        "editor.defaultFormatter" = "tamasfe.even-better-toml";
      };
      "[python]" = {
        "editor.defaultFormatter" = "charliermarsh.ruff";
      };
      "python.analysis.typeCheckingMode" = "standard";

      "redhat.telemetry.enabled" = false;
      "yaml.format.enable" = false;
      "explorer.confirmDelete" = false;
      "typescript.updateImportsOnFileMove.enabled" = "always";
      "chat.commandCenter.enabled" = false;
      "amp.url" = "https://ampcode.com/";
      "docker.extension.enableComposeLanguageServer" = true;
      "chat.instructionsFilesLocations" = {
        ".github/instructions" = true;
        "/tmp/postman-http-request-post-response.instructions.md" = true;
        "/tmp/postman-http-request-pre-request.instructions.md" = true;
        "/tmp/postman-collections-post-response.instructions.md" = true;
        "/tmp/postman-collections-pre-request.instructions.md" = true;
        "/tmp/postman-folder-post-response.instructions.md" = true;
        "/tmp/postman-folder-pre-request.instructions.md" = true;
      };
      "postman.mcp.notifications.postmanMCP" = false;
      "chat.mcp.gallery.enabled" = true;

      # Amp settings
      "amp.mcpServers" = {
        "chrome-devtools" = {
          "command" = "npx";
          "args" = [
            "chrome-devtools-mcp@latest"
            "-e"
            "/etc/profiles/per-user/albertjul/bin/google-chrome-stable"
          ];
          "env" = { };
        };
      };

      "amp.permissions" = [
        {
          "tool" = "Bash";
          "action" = "ask";
          "matches" = {
            "cmd" = "*git*push*";
          };
        }
        {
          "tool" = "mcp__*";
          "action" = "allow";
        }
        {
          "tool" = "read_mcp_resource";
          "action" = "allow";
        }
        {
          "tool" = "tb__*";
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^(.*\\s+)?(bazel|ibazel)\\s+.*\\/\\/[^\\s]*.*$/";
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "ls"
              "ls *"
              "dir"
              "dir *"
              "cat *"
              "head *"
              "tail *"
              "less *"
              "more *"
              "grep *"
              "egrep *"
              "fgrep *"
              "tree"
              "tree *"
              "file *"
              "wc *"
              "pwd"
              "stat *"
              "du *"
              "df *"
              "ps *"
              "top"
              "htop"
              "echo *"
              "printenv *"
              "id"
              "which *"
              "whereis *"
              "date"
              "cal *"
              "uptime"
              "free *"
              "ping *"
              "dig *"
              "nslookup *"
              "host *"
              "netstat *"
              "ss *"
              "lsof *"
              "ifconfig *"
              "ip *"
              "man *"
              "info *"
              "mkdir *"
              "touch *"
              "uname *"
              "whoami"
              "go version"
              "go env *"
              "go help *"
              "cargo version"
              "cargo --version"
              "cargo help *"
              "rustc --version"
              "rustc --help"
              "rustc --explain *"
              "javac --version"
              "javac -version"
              "javac -help"
              "javac --help"
              "dotnet --info"
              "dotnet --version"
              "dotnet --help"
              "dotnet help *"
              "gcc --version"
              "gcc -v"
              "gcc --help"
              "gcc -dumpversion"
              "g++ --version"
              "g++ -v"
              "g++ --help"
              "g++ -dumpversion"
              "clang --version"
              "clang --help"
              "clang++ --version"
              "clang++ --help"
              "python -V"
              "python --version"
              "python -h"
              "python --help"
              "python3 -V"
              "python3 --version"
              "python3 -h"
              "python3 --help"
              "ruby -v"
              "ruby --version"
              "ruby -h"
              "ruby --help"
              "node -v"
              "node --version"
              "node -h"
              "node --help"
              "npm --help"
              "npm --version"
              "npm -v"
              "npm help *"
              "yarn --help"
              "yarn --version"
              "yarn -v"
              "yarn help *"
              "pnpm --help"
              "pnpm --version"
              "pnpm -v"
              "pnpm help *"
              "pytest -h"
              "pytest --help"
              "pytest --version"
              "jest --help"
              "jest --version"
              "mocha --help"
              "mocha --version"
              "make --version"
              "make --help"
              "docker --version"
              "docker --help"
              "docker version"
              "docker help *"
              "git --version"
              "git --help"
              "git help *"
              "git version"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "go test *"
              "go run *"
              "go build *"
              "go vet *"
              "go fmt *"
              "go list *"
              "cargo test *"
              "cargo run *"
              "cargo build *"
              "cargo check *"
              "cargo fmt *"
              "cargo tree *"
              "make -n *"
              "make --dry-run *"
              "mvn test *"
              "mvn verify *"
              "mvn dependency=tree *"
              "gradle tasks *"
              "gradle dependencies *"
              "gradle properties *"
              "dotnet test *"
              "dotnet list *"
              "python -c *"
              "ruby -e *"
              "node -e *"
              "npm list *"
              "npm ls *"
              "npm outdated *"
              "npm test*"
              "npm run*"
              "npm view *"
              "npm info *"
              "yarn list*"
              "yarn ls *"
              "yarn info *"
              "yarn test*"
              "yarn run *"
              "yarn why *"
              "pnpm list*"
              "pnpm ls *"
              "pnpm outdated *"
              "pnpm test*"
              "pnpm run *"
              "pytest --collect-only *"
              "jest --listTests *"
              "jest --showConfig *"
              "mocha --list *"
              "git status*"
              "git show *"
              "git diff *"
              "git grep *"
              "git branch *"
              "git tag *"
              "git remote -v *"
              "git rev-parse --is-inside-work-tree *"
              "git rev-parse --show-toplevel *"
              "git config --list *"
              "git log *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "./gradlew *"
              "./mvnw *"
              "./build.sh *"
              "./configure *"
              "cmake *"
              "./node_modules/.bin/tsc *"
              "./node_modules/.bin/eslint *"
              "./node_modules/.bin/prettier *"
              "prettier *"
              "./node_modules/.bin/tailwindcss *"
              "./node_modules/.bin/tsx *"
              "./node_modules/.bin/vite *"
              "bun *"
              "tsx *"
              "vite *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              ".venv/bin/activate *"
              ".venv/Scripts/activate *"
              "source .venv/bin/activate *"
              "source venv/bin/activate *"
              "pip list *"
              "pip show *"
              "pip check *"
              "pip freeze *"
              "uv *"
              "poetry show *"
              "poetry check *"
              "pipenv check *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "asdf list *"
              "asdf current *"
              "asdf which *"
              "mise list *"
              "mise current *"
              "mise which *"
              "mise use *"
              "rbenv version *"
              "rbenv versions *"
              "rbenv which *"
              "nvm list *"
              "nvm current *"
              "nvm which *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "./test*"
              "./run_tests.sh *"
              "./run_*_tests.sh *"
              "vitest *"
              "bundle exec rspec *"
              "bundle exec rubocop *"
              "rspec *"
              "rubocop *"
              "swiftlint *"
              "clippy *"
              "ruff *"
              "black *"
              "isort *"
              "mypy *"
              "flake8 *"
              "bandit *"
              "safety *"
              "biome check *"
              "biome format *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "rails server *"
              "rails s *"
              "bin/rails server *"
              "bin/rails s *"
              "flask run *"
              "django-admin runserver *"
              "python manage.py runserver *"
              "uvicorn *"
              "streamlit run *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "bin/rails db=status"
              "bin/rails db=version"
              "rails db=rollback *"
              "rails db=status *"
              "rails db=version *"
              "alembic current *"
              "alembic history *"
              "bundle exec rails db=status"
              "bundle exec rails db=version"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "docker ps *"
              "docker images *"
              "docker logs *"
              "docker inspect *"
              "docker info *"
              "docker stats *"
              "docker system df *"
              "docker system info *"
              "podman ps *"
              "podman images *"
              "podman logs *"
              "podman inspect *"
              "podman info *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "aws --version *"
              "aws configure list *"
              "aws sts get-caller-identity *"
              "aws s3 ls *"
              "gcloud config list *"
              "gcloud auth list *"
              "gcloud projects list *"
              "az account list *"
              "az account show *"
              "kubectl get *"
              "kubectl describe *"
              "kubectl logs *"
              "kubectl version *"
              "helm list *"
              "helm status *"
              "helm version *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "swift build *"
              "swift test *"
              "zig build *"
              "zig build test*"
              "kotlinc *"
              "scalac *"
              "javac *"
              "javap *"
              "clang *"
              "jar *"
              "sbt *"
              "gradle *"
              "bazel build *"
              "bazel test *"
              "bazel run *"
              "mix *"
              "lua *"
              "ruby *"
              "php *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "mkdir -p *"
              "chmod +x *"
              "dos2unix *"
              "unix2dos *"
              "ln -s *"
            ];
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = [
              "for *"
              "while *"
              "do *"
              "done *"
              "if *"
              "then *"
              "else *"
              "elif *"
              "fi *"
              "case *"
              "esac *"
              "in *"
              "function *"
              "select *"
              "until *"
              "{ *"
              "} *"
              "[[ *"
              "]] *"
            ];
          };
          "action" = "ask";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^find(?!.*(-delete|-exec|-execdir)).*$/";
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^(echo|ls|pwd|date|whoami|id|uname)\\s.*[&|;].*\\s*(echo|ls|pwd|date|whoami|id|uname)($|\\s.*/";
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^(cat|grep|head|tail|less|more|find)\\s.*\\|\\s*(grep|head|tail|less|more|wc|sort|uniq)($|\\s.*/";
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^rm\\s+.*(-[rf].*-[rf]|-[rf]{2;}|--recursive.*--force|--force.*--recursive).*$/";
          };
          "action" = "ask";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^find.*(-delete|-exec|-execdir).*$/";
          };
          "action" = "ask";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^(ls|cat|grep|head|tail|file|stat)\\s+[^/]*$/";
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/^(?!.*(rm|mv|cp|chmod|chown|sudo|su|dd)\\b).*/dev/(null|zero|stdout|stderr|stdin).*$/";
          };
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "matches" = {
            "cmd" = "/(^|\\s)(\\/(?!dev\\/(null|zero|stdout|stderr|stdin))[^\\s]*|\\.\\.\\/)(?![^\\s]*\\.(log|txt|md|json|yml|yaml)$)/";
          };
          "action" = "ask";
        }
        {
          "tool" = "Bash";
          "action" = "ask";
        }
        {
          "tool" = "Glob";
          "action" = "allow";
        }
        {
          "tool" = "Task";
          "action" = "allow";
        }
        {
          "tool" = "chat_llm";
          "action" = "allow";
        }
        {
          "tool" = "finder";
          "action" = "allow";
        }
        {
          "tool" = "fast_finder";
          "action" = "allow";
        }
        {
          "tool" = "xai_finder";
          "action" = "allow";
        }
        {
          "tool" = "kimiK2_finder";
          "action" = "allow";
        }
        {
          "tool" = "gossip_finder";
          "action" = "allow";
        }
        {
          "tool" = "sonoma_finder";
          "action" = "allow";
        }
        {
          "tool" = "get_diagnostics";
          "action" = "allow";
        }
        {
          "tool" = "Bash";
          "action" = "allow";
        }
        {
          "tool" = "oracle";
          "action" = "allow";
        }
        {
          "tool" = "mermaid";
          "action" = "allow";
        }
        {
          "tool" = "todo_read";
          "action" = "allow";
        }
        {
          "tool" = "todo_write";
          "action" = "allow";
        }
        {
          "tool" = "read_web_page";
          "action" = "allow";
        }
        {
          "tool" = "run_javascript";
          "action" = "allow";
        }
        {
          "tool" = "create_file";
          "action" = "allow";
        }
        {
          "tool" = "glob";
          "action" = "allow";
        }
        {
          "tool" = "Glob";
          "action" = "allow";
        }
        {
          "tool" = "undo_edit";
          "action" = "allow";
        }
        {
          "tool" = "Read";
          "action" = "allow";
        }
        {
          "tool" = "edit_file";
          "action" = "allow";
        }
        {
          "tool" = "format_file";
          "action" = "allow";
        }
        {
          "tool" = "web_search";
          "action" = "allow";
        }
        {
          "tool" = "Grep";
          "action" = "allow";
        }
        {
          "tool" = "search_documents";
          "action" = "allow";
        }
        {
          "tool" = "get_document";
          "action" = "allow";
        }
        {
          "tool" = "Check";
          "action" = "allow";
        }
        {
          "tool" = "code_review";
          "action" = "allow";
        }
        {
          "tool" = "librarian";
          "action" = "allow";
        }
      ];
    };
  };
}
