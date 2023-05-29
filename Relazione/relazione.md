Fabio Fontana 4891185 , Federico Fontana 4835118 , Roberto Castellotti 4801634

# Relazione

## Modalità di svolgimento dei test
I test principali sono sati svolti mediante connessione mobile (Vodafone, ping: 35 ms, jitter: 35 ms, download: 30 Mbps, upload: 1 Mbps).

I test si sono svolti sia in localhost, con il pong_server che abbiamo completato (`./pong_server 3000`), sia connettendosi al server remoto (`webdev.dibris.unige.it:1491`).

Abbiamo stabilito i seguenti paramentri:
- size minima: 64
- size massima: 65536
- ripetizioni: 1024

## Risultati (localhost)

### Throughput medio e mediano calcolato
<img src="throughput_localhost.png" style="zoom:60%" />
![]()

### Throughput calcolato e throughput ottenuto con il modello banda-latenza (TCP)
<img src="tcp_localhost.png" style="zoom:60%" />

### Throughput calcolato e throughput ottenuto con il modello banda-latenza (UDP)
<img src="udp_localhost.png" style="zoom:60%" />

<br>

## Risultati (webdev.dibris.unige.it)

### Throughput medio e mediano calcolato
<img src="throughput.png" style="zoom:60%" />


### Throughput calcolato e throughput ottenuto con il modello banda-latenza (TCP)
<img src="tcp.png" style="zoom:60%" />



### Throughput calcolato e throughput ottenuto con il modello banda-latenza (UDP)
<img src="udp.png" style="zoom:60%" />

## Considerazioni
Come si può notare dai risultati in localhost il throughput UDP è notevolmente superiore al throughput TCP rispetto ai risultati ottenuti con il server remoto. Questo è possibile grazie alla banda disponibile che è nettamente superiore in locale.

È anche bene notare che nella trasmissione UDP (server remoto) di pacchetti con size superiore a 8192 non è possibile analizzare i dati in quanto vengono persi troppi pacchetti (testimoniato dalla generazione di file .broken).

Questo è probabilmente dovuto dalla limitazione dovuta all'MTU. Infatti UDP frammenta in molti piccoli pacchetti e li invia al server causando una possibile congestione di rete con una conseguente perdita di pacchetti.

È bene ricordare che il throughput UDP non è condizionato dalla latenza a differenza di quello TCP (il client non attende una risposta di tipo ACK dal server, pertanto la quantità di pacchetti UDP inviata in un istante di tempo è maggiore rispetto a pacchetti TCP).

Analizzando i grafici ottenuti con il modello banda-latenza si può infatti osservare come la trasmissione TCP è stata più veloce rispetto a quella UDP con il server remoto, relazione che si ribalta nei risultati in locale.

Questo dimostra che la velocità del protocollo UDP è relativa e talvolta può essere più lenta di quella con protocollo TCP.
