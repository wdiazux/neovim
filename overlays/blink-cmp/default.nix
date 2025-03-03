{ inputs, ... }: final: prev: { blink-cmp = inputs.blink-cmp.packages.${final.system}.default; }
