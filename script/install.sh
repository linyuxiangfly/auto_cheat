#!/bin/bash

scriptDir=$1
scriptFile="${scriptDir}cheat.sh"

systemctl stop cheat.service
systemctl disable cheat.service

#/root/cheat/cheat.sh
#cat > /etc/systemd/system/cheat.service << EOF
#[Unit]
#Description=cheat
#
#[Service]
#Restart=always
#ExecStart=$scriptFile
#
#[Install]
#WantedBy=default.target
#EOF
echo "[Unit]" > /etc/systemd/system/cheat.service
echo "Description=cheat" >> /etc/systemd/system/cheat.service
echo "[Service]" >> /etc/systemd/system/cheat.service
echo "Restart=always" >> /etc/systemd/system/cheat.service
echo "ExecStart=${scriptFile}" >> /etc/systemd/system/cheat.service
echo "[Install]" >> /etc/systemd/system/cheat.service
echo "WantedBy=default.target" >> /etc/systemd/system/cheat.service

systemctl enable cheat.service
systemctl start cheat.service
