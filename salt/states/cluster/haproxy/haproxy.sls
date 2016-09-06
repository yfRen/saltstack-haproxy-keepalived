haproxy-install:
  pkg.installed:
    - names:
      - haproxy

haproxy-config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://cluster/haproxy/files/haproxy-outside.cfg
    - user: root
    - group: root
    - mode: 755

haproxy-service:
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - pkg: haproxy-install
      - file: haproxy-config
    - watch:
      - file: haproxy-config

net.ipv4.ip_nonlocal_bind:
  sysctl.present:
    - value: 1
