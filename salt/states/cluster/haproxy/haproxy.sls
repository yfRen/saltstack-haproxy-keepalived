haproxy-install:
  pkg.installed:
    - names:
      - epel-release
      - haproxy

haproxy-config:
  file.managed:
    - name: /etc/haproxy/haproxy.cfg
    - source: salt://cluster/haproxy/files/haproxy-outside.cfg
    - user: root
    - group: root
    - mode: 644

set-haproxy-log:
  file.managed:
    - name: /usr/local/src/set_log.sh
    - source: salt://cluster/haproxy/files/set_log.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /usr/local/src && sh set_log.sh && sleep 2 && touch set_log.sh.lock
    - unless: test -e /usr/local/src/set_log.sh.lock
    - require:
      - file: set-haproxy-log

haproxy-service:
  service.running:
    - name: haproxy
    - enable: True
    - reload: True
    - require:
      - file: set-haproxy-log
