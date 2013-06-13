Description
===========

Installs and configures a mail server using [Postfix](http://www.postfix.org/), [Dovecot](http://www.dovecot.org/), [PostfixAdmin](http://postfixadmin.sourceforge.net/) and [SpamAssassin](http://spamassassin.apache.org/).

Requirements
============

## Platform:

This cookbook has been tested on the following platforms:

* Centos >= 6.0
* Debian >= 7.0
* Ubuntu >= 12.04

Let me know if you use it successfully on any other platform.

## Cookbooks:

* [dovecot](https://github.com/onddo/dovecot-cookbook)
* [onddo-spamassassin](https://github.com/onddo/spamassassin-cookbook)
* [postfixadmin](https://github.com/onddo/postfixadmin-cookbook)
* [postfix-full](https://github.com/mswart/chef-postfix-full) by [@mswart](https://github.com/mswart)

## Applications:

* **Dovecot >= 2**: requires this version of dovecot to be available by the distribution's package manager.

Attributes
==========

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['postmaster_address']</code></td>
    <td>Postmaster mail address.</td>
    <td><code>"postmaster@foo.bar"</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['hostname']</code></td>
    <td>Hostname.</td>
    <td><code>node["fqdn"]</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['sieve']['enabled']</code></td>
    <td>Whether to enable sieve.</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['sieve']['global_path']</code></td>
    <td>Sieve global path.</td>
    <td><code>"#{default["dovecot"]["conf_path"]}/sieve/default.sieve"</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['spamc']['enabled']</code></td>
    <td>Whether to enable SpamAssassin</td>
    <td><code>true</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['spamc']['recipe']</code></td>
    <td>Spamc recipe name to use.</td>
    <td><code>"onddo-spamassassin"</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['vmail']['user']</code></td>
    <td>Virtual mail system user name.</td>
    <td><code>"vmail"</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['vmail']['group']</code></td>
    <td>Virtual mail system group name.</td>
    <td><code>node["postfix-dovecot"]["vmail"]["user"]</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['vmail']['uid']</code></td>
    <td>Virtual mail system user id.</td>
    <td><code>5000</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['vmail']['gid']</code></td>
    <td>Virtual mail system group id.</td>
    <td><code>node["postfix-dovecot"]["vmail"]["uid"]</code></td>
  </tr>
  <tr>
    <td><code>node['postfix-dovecot']['vmail']['home']</code></td>
    <td>Virtual mail user home path.</td>
    <td><code>"/var/vmail"</code></td>
  </tr>
</table>

Recipes
=======

## postfix-dovecot::default

Installs and configures everything.

## postfix-dovecot::vmail

Creates vmail user.

## postfix-dovecot::spam

Installs and configures SpamAssassin.

## postfix-dovecot::postfix-full

Installs and configures Postfix.

## postfix-dovecot::postfixadmin

Installs and configures PostfixAdmin.

## postfix-dovecot::dovecot

Installs and configures Dovecot 2.

Usage Example
=============

## Including in a Cookbook Recipe

Running it from a recipe:

```ruby
include_recipe 'postfix-dovecot::default'
```

Don't forget to include the `postfix-dovecot` cookbook as a dependency in the metadata.

```ruby
# metadata.rb
[...]

depends 'postfix-dovecot'
```

## Including in the Run List

Another alternative is to include the default recipe in your *Run List*.

```json
{
  "name": "mail.onddo.com",
  [...]
  "run_list": [
    [...]
    "recipe[postfix-dovecot]"
  ]
}
```

Testing
=======

## Requirements

* `vagrant`
* `berkshelf` >= `1.4.0`
* `test-kitchen` >= `1.0.0.alpha`
* `kitchen-vagrant` >= `0.10.0`

## Running the tests

```bash
$ kitchen test
$ kitchen verify
[...]
```

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


License and Author
=====================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Xabier de Zuazo (<xabier@onddo.com>)
| **Copyright:**       | Copyright (c) 2013 Onddo Labs, SL. (www.onddo.com)
| **License:**         | Apache License, Version 2.0

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

