# AGENTS.md

Guidance for agents working in this repo.

## What this is

A personal NixOS + Home Manager flake configuration, structured with
[Dendritic](https://github.com/vic/den) pattern modules (via `den` +
`flake-parts` + `import-tree`). Every `.nix` file under `modules/` is
auto-imported — there is no manual import list to maintain.

- `flake.nix` — entry point. **Auto-generated**, do not hand-edit (see below).
- `modules/` — all configuration, as flake-parts modules.
  - `modules/dendritic.nix` — wires in the `den`/`flake-file` dendritic flakeModules.
  - `modules/inputs.nix`, `modules/home-manager.nix` — shared flake inputs / base HM config.
  - `modules/hosts.nix` — declares hosts (`den.hosts.<system>.<hostname>`).
  - `modules/hosts/<HostName>/` — per-host aspect wiring + hardware config (disk layout, GPU, etc).
  - `modules/users/<username>.nix` — per-user aspect wiring + HM config.
  - `modules/aspects/<category>/<name>.nix` — one feature/app/service per file, declared as
    `den.aspects.<name>` (or `den.aspects.<category>.provides.<name>` for a namespaced variant,
    e.g. `den.aspects.ai.provides.claude-code`).
  - `modules/secrets/` — sops-nix wiring; secrets content itself lives in a separate encrypted
    `config-secrets` flake input, not in this repo.
  - `modules/state-versions.nix` — pins `system.stateVersion` / `home.stateVersion`. **Never
    change these** without reading the comments in that file first.

## The aspect pattern (read before adding anything)

Look at an existing aspect before writing a new one — e.g.
`modules/aspects/apps/steam.nix`, `modules/aspects/ai/claude-code.nix`,
`modules/aspects/secrets/secrets.nix` — instead of guessing the shape.

Each aspect module is scoped and declares only what it owns:

```nix
{ den, inputs, ... }:
{
  # Register any new flake inputs this aspect needs.
  flake-file.inputs.someInput.url = "github:owner/repo";

  den.aspects.<name> = {
    includes = [ den.aspects.otherAspect ];   # compose other aspects in
    nixos = { pkgs, ... }: { ... };           # NixOS module, if applicable
    homeManager = { pkgs, ... }: { ... };     # Home Manager module, if applicable
  };
}
```

- An aspect is enabled on a host/user by adding it to that host's/user's
  `includes` list (see `modules/hosts/AlbertProP16/default.nix`,
  `modules/users/albertjul.nix`) — never by importing the file directly.
- Unfree packages go through `den.batteries.unfree [ "pkg-name" ]` inside
  `includes`, not `nixpkgs.config.allowUnfree`.
- New flake inputs are declared with `flake-file.inputs.<name>` in the same
  file that uses them, not centrally — `flake.nix`'s `inputs` block is
  generated from all of these.
- File location = category directory (`ai/`, `apps/`, `cli/`, `desktop/`,
  `hardware/`, `system/`); one aspect per file, filename matches aspect name.

## Regenerating `flake.nix`

`flake.nix` has a `DO-NOT-EDIT` header. After adding/changing any
`flake-file.inputs.*` declaration, regenerate it instead of hand-editing:

```
nix run .#write-flake
```

## Building / testing changes

There's no CI in this repo. Validate changes locally before considering them done:

```
nix flake check                                   # evaluates the flake
sudo nixos-rebuild build --flake .#<HostName>      # build without switching (e.g. AlbertProP16)
sudo nixos-rebuild switch --flake .#<HostName>     # apply
home-manager build --flake .#<user>@<HostName>     # HM-only build, if needed
```

Prefer `build` over `switch` when just verifying a change compiles/evaluates
— only `switch` if asked to actually apply the system change on this
machine.

## Secrets

Actual secret values live in the separate `config-secrets` flake input
(`nixos-secrets` repo), referenced via sops-nix (`modules/secrets/secrets.nix`).
Never add plaintext secrets to this repo. New per-service secrets are wired
via `sops.secrets.*` in the aspect that needs them (see
`modules/aspects/system/restic.nix` for the pattern), and the encrypted
values themselves belong in the secrets repo, not here.

## Conventions

- Formatting: this is nixpkgs-style Nix; match the surrounding file's style
  (2-space indent, `pkgs.foo.override`-style attrsets already in use).
- Keep one concern per aspect file — don't fold multiple unrelated
  programs/services into one file just because they're related in your head.
