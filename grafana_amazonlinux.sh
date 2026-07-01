sudo yum install -y https://dl.grafana.com/grafana-enterprise/release/13.1.0/grafana-enterprise_13.1.0_28013217238_linux_amd64.rpm
sudo /bin/systemctl daemon-reload
sudo /bin/systemctl enable grafana-server
sudo /bin/systemctl start grafana-server
sudo /bin/systemctl status grafana-server --no-pager
