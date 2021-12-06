#!py


def run():
    config = {}
    # short-circuit if no autopkg w/salt's built-in os.path handling, will log error
    if salt["file.file_exists"]("/usr/local/bin/autopkg"):
        # list of tuples with recipe names/escaped path targets
        autopkgs = [
                ('1Password', '1Password\ 7.app'),
                ('Aerial', '/Library/Screen\ Savers/Aerial.saver/Contents/Info.plist'),
                ('GitHubDesktop', 'GitHub\ Desktop.app'),
                ('git-lfs', '/usr/local/bin/git-lfs'),
                ('HexFiend', 'Hex\ Fiend.app'),
                # ('"Recipe Robot"', 'Recipe\ Robot.app'),
                ('ripgrep', '/usr/local/bin/rg'),
                ('Shellcheck', '/usr/local/bin/shellcheck'),
                ('SuspiciousPackageApp', 'Suspicious\ Package.app'),
            ]
        for each in autopkgs:
            # test for app bundle as second half of tuple
            if each[1].endswith(".app"):
                config["Install_{}_with_autopkg".format(each[0])] = {
                    "cmd.run": [
                        {"runas": __pillar__["user"]},
                        {
                            "name": "/usr/local/bin/autopkg install {}".format(
                                each[0]
                            )
                        },
                        {"unless": ["/bin/test -d /Applications/{}".format(each[1])]},
                    ]
                }
            else:
                config["Install_{}_with_autopkg".format(each[0])] = {
                    "cmd.run": [
                        {"runas": __pillar__["user"]},
                        {
                            "name": "/usr/local/bin/autopkg install {}".format(
                                each[0]
                            )
                        },
                        {"unless": ["/bin/ls {}".format(each[1])]},
                    ]
                }
    return config


# {% if not salt['file.directory_exists']('/Applications/TextExpander.app') %}
# Install TextExpander with autopkg:
#   cmd.run:
#     - runas: {{ pillar['user'] }}
#     - name: /usr/local/bin/autopkg install TextExpander7
# {% endif %}
