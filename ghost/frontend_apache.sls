{% from "ghost/map.jinja" import apache with context %}
{% from "ghost/map.jinja" import ghost with context %}

ghost-frontend:
  pkg.installed:
    - name: {{ apache.pkg }}
  service.running:
    - name: {{ apache.srv }}

{%- for site in ghost.blogs %}
ghost-frontend-{{ site }}:
  file.managed:
    - name: {{ apache.conf }}/sites-available/{{ site }}.conf
    - source: salt://ghost/files/apache-site.jinja
    - mode: 644
    - watch_in:
      - service: ghost-frontend

ghost-enable-{{ site }}:
  file.symlink:
    - name: {{ apache.conf }}/sites-enabled/{{ site }}.conf
    - target: {{ apache.conf }}/sites-available/{{ site }}.conf
{%- endfor %}

