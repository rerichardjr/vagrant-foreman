# Vagrant-Foreman: Foreman lab

This repository provides a Vagrant configuration to spin up a Foreman server for testing and development purposes. The lab consists of one virtual machine (`foreman`) running Foreman, configured with a static network IP (`192.168.1.20`). Options configurable by changing settings.yaml.

## Prerequisites

- [Vagrant](https://www.vagrantup.com/) installed (see [Installing Vagrant](#installing-vagrant) below).
- [VirtualBox](https://www.virtualbox.org/) (or another supported provider) installed as the virtualization backend.
- Git installed to clone the repository (see [Cloning the Repository](#cloning-the-repository)).

## Getting Started

1. Clone the repository (see [Cloning the Repository](#cloning-the-repository)).
2. Navigate to the repository directory:
   ```bash
   cd vagrant-foreman
   ```
3. Start the Vagrant environment:
   ```bash
   vagrant up
   ```
   This will provision one VM and install foreman.

4. Wait for the provisioning to complete (this may take a few minutes depending on your system and network).

## Cloning the Repository

To get the code from GitHub:

```bash
git clone https://github.com/rerichardjr/vagrant-foreman.git
cd vagrant-foreman
```

- **Requirements**: Git must be installed.
  - On Ubuntu: `sudo apt install git`
  - On macOS: `brew install git` (with Homebrew) or via Xcode tools.
  - On Windows: Download from [git-scm.com](https://git-scm.com/) or use `winget install --id Git.Git`.

## Installing Vagrant

### On Ubuntu/Debian
```bash
sudo apt update
sudo apt install vagrant
```

### On macOS
Using Homebrew:
```bash
brew install vagrant
```
Or download the installer from [vagrantup.com](https://www.vagrantup.com/downloads).

### On Windows
1. Download the installer from [vagrantup.com](https://www.vagrantup.com/downloads).
2. Run the installer and follow the prompts.
3. Alternatively, use Winget:
   ```bash
   winget install Hashicorp.Vagrant
   ```

### Verify Installation
```bash
vagrant --version
```
## Configuration Details

- **Server**: 
  - `foreman`: `192.168.1.20`
- **Vagrant Box**: Uses a base box (e.g., `bento/ubuntu-22.04`) with Foreman installed via provisioning scripts.
- **Network**: Bridged with static IP.

## Cleaning Up

To stop and remove the VMs:
```bash
vagrant destroy -f
```

## Contributing

Feel free to fork this repo, make improvements, and submit a pull request to `https://github.com/rerichardjr/vagrant-foreman`.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
