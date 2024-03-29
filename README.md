[![License](https://img.shields.io/github/license/norumin/calendso)](LICENSE)
![Language count](https://img.shields.io/github/languages/count/norumin/calendso)
![Top language](https://img.shields.io/github/languages/top/norumin/calendso)
[![Contributors](https://img.shields.io/github/contributors/norumin/calendso)](https://github.com/norumin/calendso/graphs/contributors)
[![Stargazers](https://img.shields.io/github/stars/norumin/calendso?style=social)](https://github.com/norumin/calendso/stargazers)
[![Forks](https://img.shields.io/github/forks/norumin/calendso?style=social)](https://github.com/norumin/calendso/network/members)

# calendso

> Norumin Scheduling System

[![Infrastructure](https://github.com/norumin/calendso/actions/workflows/infrastructure.yml/badge.svg)](https://github.com/norumin/calendso/actions/workflows/infrastructure.yml)
[![Security](https://github.com/norumin/calendso/actions/workflows/security.yml/badge.svg)](https://github.com/norumin/calendso/actions/workflows/security.yml)
[![Lint](https://github.com/norumin/calendso/actions/workflows/lint.yml/badge.svg)](https://github.com/norumin/calendso/actions/workflows/lint.yml)
[![Current online status](https://img.shields.io/website?down_color=lightgrey&down_message=offline&label=cal.norum.in&up_color=blue&up_message=online&url=https%3A%2F%2Fcal.norum.in)](https://cal.norum.in)

[![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)](https://aws.amazon.com/)
[![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)](https://docker.com/)
[![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)](https://terraform.io/)
[![Terragrunt](https://img.shields.io/badge/Terragrunt-2274EA?style=for-the-badge&logo=data:image/png;base64,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)](https://terragrunt.gruntwork.io/)
[![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)](https://ansible.com/)

## ⚡ Getting started

### 1. Clone this repository

```bash
# clone from github
git clone git@github.com:norumin/calendso.git

# cd into repo directory
cd calendso
```

### 2. Configure project

1. Prepare dotenv file at `.env`. If you don't have `.env` file, you can create a new one by `cp .env.example .env` and
   customize with your own settings.
2. Prepare keypair file at `.keypair.pem`. You should either download from your secret vault or generate one by
   `just keygen` if you don't have already.

### 3. Intialize project

```bash
just init
```

### 4. Try create an execution plan

```bash
just tg plan
```

## 👋 Contributions

Contributions are welcome by opening issues and pull requests. See [CONTRIBUTING.md](CONTRIBUTING.md) file for details.

## 🚧 Roadmap

- [ ] Use a dedicated docker context inside build module
- [ ] DB instance inside private subnet
- [ ] Prisma studio exposed by nginx
- [ ] Backup strategies
- [ ] Multi-platform builds by buildx
- [ ] More secure security groups
- [ ] Other env vars
- [ ] Prevent emails are falling into spam folder

## 📄 License

This project is licensed under the **MIT License**.

## 🙇 Credits

- Thanks to [@calcom](https://github.com/calcom) for building this powerful scheduling app.
