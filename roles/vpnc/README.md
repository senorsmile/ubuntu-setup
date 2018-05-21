# vpnc Ansible Role
Role to install and manage vpnc (a command line cisco vpn client)

## Define vars
You can define one or more configurations, as separate list items.

For example:
```
  vpnc_confs:
    - name: example_corp1
      gateway:   'vpn.example.com'
      group_id:  'group
      group_psk: 'password'
      username:  'myuser'
      password:  'mypass'
```

## Add role to your site playbook
This role requires root, so make sure you define
```  
  become: True
```

## Connect/Disconnect
To connect, use:
```
  sudo vpnc-connect /etc/vpnc/example_corp1.conf
```

and to disconnect, simply
```
  sudo vpnc-disconnect
```
