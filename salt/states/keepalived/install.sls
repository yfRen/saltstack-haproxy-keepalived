keepalived_install:
  pkg.installed:
    - names:
      - keepalived

keepalived_config:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://keepalived/files/keepalived.conf
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:  
      ROUTEID: {{ pillar['keepalived']['ROUTEID'] }}
      STATEID: {{ pillar['keepalived']['STATEID'] }}
      PRIORITYID: {{ pillar['keepalived']['PRIORITYID'] }}
      VIP: {{ pillar['keepalived']['VIP'] }}

check_haproxy_script:
  file.managed:
    - name: /etc/keepalived/check_haproxy.sh
    - source: salt://keepalived/files/check_haproxy.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      VIP: {{ pillar['keepalived']['VIP'] }}

keepalived_service:
  service.running:
    - name: keepalived
    - enable: True
    - reload: True
    - require:
      - pkg: keepalived_install
      - file: keepalived_config
      - file: check_haproxy_script
    - watch:
      - file: keepalived_config
