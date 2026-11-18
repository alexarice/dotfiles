{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:
lib.mkIf (lib.elem config.machine ["desktop" "framework"]) {
  containers.container = {
    specialArgs.inputs = inputs;
    config = {pkgs, ...}: {
      imports = [
        ../.
      ];

      machine = "container";

      hm.home.packages = with pkgs; [
        bash
        uv
        ripgrep
        curl
        nodejs
        python315
        ddgr
        basedpyright
        texliveFull
        inputs.eca.packages."x86_64-linux".eca
      ];

      hm.xdg.configFile."eca/config.json".text = builtins.toJSON {
        providers = {
          elm = {
            api = "openai-chat";
            url = "https://elm.edina.ac.uk/api/v1";
            key = "\${file:/home/alex/.elm-key}";
            models = {
              "Qwen" = {
                modelName = "Qwen/Qwen3.5-397B-A17B-FP8";
                limit = {
                  context = 262144;
                  output = 81920;
                };
              };
            };
          };
        };
        defaultModel = "elm/Qwen";
        chat = {
          defaultTrust = true;
        };
        toolCall = {
          approval = {
            deny = {
              git = {};
              eca__git = {};
              shell_command = {
                argsMatchers = {
                  command = ["^.*\\bgit\\b.*"];
                };
              };
            };
          };
        };
        mcpServers = {
          arxiv = {
            command = "uvx";
            args = ["arxiv-mcp-server"];
          };
        };
        customTools = {
          elm-websearch = {
            description = ''
              Search the public web via University of Edinburgh ELM API.
              Returns ranked sources with URLs and content for citation-backed answers.
              Use for recent facts, news, changing documentation, verification, and requests for sources.
            '';
            command = ''
              curl -s -X POST 'https://elm.edina.ac.uk/api/v1/search' \
                -H 'Authorization: Bearer ''${file:/home/alex/.elm-key}' \
                -H 'Content-Type: application/json' \
                -d '{"q":"{{query}}","depth":"{{depth}}","maxResults":{{max_results}},"outputType":"searchResults"}'
            '';
            schema = {
              properties = {
                query = {
                  type = "string";
                  description = "Focused natural-language web search query";
                };
                depth = {
                  type = "string";
                  enum = ["fast" "standard" "deep"];
                  description = ''
                    Search depth; defaults to standard.
                    Use fast for short keyword lookups, deep for complex multi-step research.
                  '';
                };
                max_results = {
                  type = "integer";
                  minimum = 1;
                  maximum = 100;
                  description = "Maximum number of results to return; defaults to 10";
                };
              };
              required = ["query" "depth" "max_results"];
            };
          };
        };
      };

      # ECA skill for elm-websearch
      hm.xdg.configFile."eca/skills/elm-websearch/SKILL.md".source =
        ./skills/elm-websearch/SKILL.md;
    };

    bindMounts = {
      "/home/alex/software" = {
        hostPath = "/home/alex/software";
        isReadOnly = false;
      };
      "/home/alex/dotfiles" = {
        hostPath = "/home/alex/dotfiles";
        isReadOnly = false;
      };
      "/home/alex/research" = {
        hostPath = "/home/alex/research";
        isReadOnly = true;
      };
      "/home/alex/scratch" = {
        hostPath = "/home/alex/scratch";
        isReadOnly = false;
      };
    };
  };
}
