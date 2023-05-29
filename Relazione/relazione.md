Giacomo Gherardi S4235299, Insinna Luca S4804022


# Relazione

## Test effettuati 
## Localhost


	./pong_server 1421
	./tcp_ping localhost 1421 100
	./udp_ping localhost 1421 100

## Server seti.dibris.unige.it


	/tcp_ping seti.dibris.unige.it 1491 100
	/udp_ping seti.dibris.unige.it 1491 100


## localhost

	./mkfile.bash 32 1024 1024 501 localhost 1421


	./band_latency.bash tcp
	./band_latency.bash udp

## seti.dibris.unige.it

	./mkfile.bash 32 1024 1024 501 seti.dibris.unige.it 1491

	./band_latency.bash tcp
	./band_latency.bash udp


## Risultati (localhost)

### Throughput medio e mediano calcolato
<img src="grafici/throughput localhost.png" style="zoom:60%" />


### Throughput calcolato e throughput ottenuto con il modello banda-latenza (TCP)
<img src="grafici/tcp localhost.png" style="zoom:60%" />

### Throughput calcolato e throughput ottenuto con il modello banda-latenza (UDP)
<img src="grafici/udp localhost.png" style="zoom:60%" />

<br>

## Risultati (seti.dibris.unige.it)

### Throughput medio e mediano calcolato
<img src="grafici/throughput server unige.png" style="zoom:60%" />


### Throughput calcolato e throughput ottenuto con il modello banda-latenza (TCP)
<img src="grafici/tcp server unige.png" style="zoom:60%" />


### Throughput calcolato e throughput ottenuto con il modello banda-latenza (UDP)
<img src="grafici/udp server unige.png" style="zoom:60%" />

## Considerazioni
Abbiamo riscontrato le maggiori difficoltà durante la scrittura dello script band_latency.bash , poiché si tratta di un linguaggio abbastanza sconosciuto per noi. Questo ha comportato notevoli ostacoli nell'implementazione dei codici.

Test eseguiti su macchina Mac (tramite vm con Ubuntu) CPU 2,3 GHz Intel Core i5 quad-core , RAM 8GB