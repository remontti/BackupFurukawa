# BACKUP FURUKAWA - OLT

Backup OLT Furukawa via SSH

### Arquivo: backup-fkw.py
Script em python3, metodo de uso:
```
# backup-fkw.py {IP} {USUARIO_SSH} {SENHA} {PORTA} {IDENTIFICACAO}
```
Os comandos executados são:
<pre>
<b>enable</b> - (Se tiver senha não irá funcionar)
<b>terminal length 0</b> - Não limitar as saídas
<b>show running-config</b> - Exibir toda a configuração
<b>no terminal length</b> - Voltar a padrão com paginação nas saídas
</pre>
### Arquivo: OLTs
Com base nisso crie um arquivo com a lista de todas suas OLTs que deve gerar o backup:
```
IP,USUARIO,SENHA,PORTA,IDENTIFICACAO
172.18.1.2,root,123456,22,OLT_RIO_GRANDE_GELADO
```

### Arquivo gerabackup.sh
Iremos gerar um <b>for</b> executando o backup-fkw.py em toda nossa lista.
Ajuste o mesmo informado em <b>DIR</b> ex /root/scripts/BackupFurukawa o local onde fica seu script.
Na linha <b>mv *.txt /home/backups/oltfurukawa/</b> ajuste para o local qual queira salvar seu backup. 
Será salvo um arquivo para cada OLT no formato  aaaa-mm-dd_identificacao.txt	

### ERROS
Antes de rodar o script faça um SSH do seu terminal para a OLT para o mesmo criar a entrada em <b>/root/.ssh/known_hosts</b> exemplo:
```
# ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 usuario_ssh@172.18.1.2
```

## CRON
```
# crontab -e 
```
Adicione:
```
# Backup OLTs Furukawa (Todos os dias 19h)
00  19  *   *   *    /root/scripts/BackupFurukawa/gerabackup.sh
```
Reinicie o cron:
```
# systemctl restart cron.service
```

### Rotina de limpeza
Adicione ao cron ou script o comando para remover os arquivos mais antigos que 60 dias: 
```
find /home/backups/oltfurukawa/* -mtime +60 -exec rm {} \;
```

