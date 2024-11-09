{ lib, config, ... }:
{
  plugins = {
    chatgpt = {
      enable = true;

      settings = rec {
        api_host_cmd = "echo -n https://openrouter.ai/api";
        api_type_cmd = "echo localai";
        openai_params = {
          model = "anthropic/claude-3.5-sonnet";
          max_tokens = "4095";
        };
        openai_edit_params = {
          inherit (openai_params) model;
        };
        extra_curl_params = [
          "-H"
          "HTTP-Referer: http://www.gooogle.com"
          "-H"
          "X-Title: ChatGPTnvim"
        ];
      };
    };
  };

  keymaps = lib.mkIf config.plugins.chatgpt.enable [
    {
      mode = "n";
      key = "<leader>uc";
      action = "<cmd>ChatGPT<CR>";
      options.desc = "ChatGTP Chat";
    }
  ];
}
