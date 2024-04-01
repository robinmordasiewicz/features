
# PowerShell (powershell)

Installs PowerShell along with needed dependencies. Useful for base Dockerfiles that often are missing required install dependencies like gpg.

## Example Usage

```json
"features": {
    "ghcr.io/robinmordasiewicz/features/powershell:0": {}
}
```

## Options

| Options Id | Description | Type | Default Value |
|-----|-----|-----|-----|
| modules | Optional comma separated list of PowerShell modules to install. | string | - |
| powershellProfileURL | Optional (publicly accessible) URL to download PowerShell profile. | string | - |
| version | Select or enter a version of PowerShell. | string | latest |

## Customizations

### VS Code Extensions

- `ms-vscode.powershell`



---

_Note: This file was auto-generated from the [devcontainer-feature.json](https://github.com/robinmordasiewicz/features/blob/main/src/powershell/devcontainer-feature.json).  Add additional notes to a `NOTES.md`._
