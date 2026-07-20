{pkgs, use_cuda ? true, ...}: {
  services.ollama = {
    enable = true;
    # Optional: preload models, see https://ollama.com/library
    loadModels = [ "llama3.2:3b" "deepseek-r1:1.5b"];
    package = if use_cuda then pkgs.ollama-cuda else pkgs.ollama-cpu;
  };
}