# This is an example of the development environment setup. This document is valid only for a company or a holding. **This document is not for EVERYONE**.

- OS
    - Ubuntu
        - Only 20.04 LTS
        - Only from ubunto.com
        - Only English (US) as default

- Software
    - Git
        - Only 2.31.1
        - Only from https://git-scm.com/downloads

    - VS Code (any version above 1.56.2)
        - Must install [Grammarly Unofficial Extension](https://marketplace.visualstudio.com/items?itemName=znck.grammarly&ssr=false#overview)
        - Must install [Docker extension](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-docker)
    - Docker
        - Only from [docker.com](https://docs.docker.com/engine/install/ubuntu/#install-using-the-repository) and using `apt` repository
        - Must be accompanied by [composer](https://docs.docker.com/compose/install/)
- Development
    - For each company (top-level URL path segment in GitHub for example), create a directory in / (root). For example,    
    `mkdir /nefcanto`.   
        - Make sure the name maps the URL segment or the company name
        - Use [snake-casing](https://en.wikipedia.org/wiki/Snake_case) for naming
    - Give that folder full permission so that all applications would work without bothering your development with `sudo` stuff:   
    `sudo chmod -R 777 /nefcanto`

<hr />

# Arguments

- Pros
    - Maximum level of consistency across the entire organization or holding
    - Drastically facilitates cooperation and teamwork
    - Reduces costs notably
    - Increases efficiency
        - Not at the cost of effectiveness
- Cons
    - Limits employee freedom
    - Makes the recruitment process more difficult
    - Can be regarded as a form of technocratic dictatorship