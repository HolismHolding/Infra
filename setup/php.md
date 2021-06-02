# PHP

If you want to develop using PHP, run these commands:

- `sudo apt-get update`
- `sudo apt -y install software-properties-common`
- `sudo add-apt-repository ppa:ondrej/php`
- `sudo apt-get update`
- `sudo apt -y install php7.4`
    - Only version 7.4 at this time

To make sure it's installed, get its version:

`php -v`

<hr />

Now install **composer**. Run these commands:

- `php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"`
- `php -r "if (hash_file('sha384', 'composer-setup.php') === '756890a4488ce9024fc62c56153228907f1545c228516cbf63f885e036d37e9a59d27d63f46af1d4d07ee0f76181c7d3') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;"`
- `php composer-setup.php`
- `php -r "unlink('composer-setup.php');"`
- `sudo mv composer.phar /usr/local/bin/composer`

Then make sure **composer** is installed by getting its version:

`composer --version`
