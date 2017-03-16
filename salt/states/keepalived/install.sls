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
      INSTANCE_NAME: {{ pillar['keepalived']['INSTANCE_NAME'] }}
      STATEID: {{ pillar['keepalived']['STATEID'] }}
      ROUTER_ID: {{ pillar['keepalived']['ROUTER_ID'] }}
      PRIORITYID: {{ pillar['keepalived']['PRIORITYID'] }}
      AUTH_TYPE: {{ pillar['keepalived']['AUTH_TYPE'] }}
      AUTH_PASS: {{ pillar['keepalived']['AUTH_PASS'] }}
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
