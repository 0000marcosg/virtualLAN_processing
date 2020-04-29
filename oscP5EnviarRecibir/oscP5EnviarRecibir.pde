/**
 * oscP5sendreceive by andreas schlegel
 * Adaptado para usar por ALC
 * Este ejemplo requiere que se instale la biblioteca oscP5. Scketch -> Importar Biblioteca -> Añadir Biblioteca. Buscar oscP5 e instalar
 */

import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;

void setup() {
  size(400, 400);
  frameRate(25);
  /* inicia oscP5, espera nuevos mensajes en el puerto 12000 */
  oscP5 = new OscP5(this, 12000);


  /* myRemoteLocation es una direccion NetAdress. Necesita dos parametros,  un numero ip y un puerto.
   * Estos dos datos (el ip y el puerto) deben ser proporcionados por la computadora de destino
   * a la que le vamos a estar enviando los datos.
   */
  myRemoteLocation = new NetAddress("127.0.0.1", 12000);
}


void draw() {
  background(0);
}

void mousePressed() {
  /* En estas lineas se crea el mensaje que se envia al clickear */
  // Primero creamos una etiqueta con el nombre del mensaje, el nombre puede ser cualquier cosa, siempre precedido por /
  OscMessage myMessage = new OscMessage("/test");

  //Le agregamos un dato al mensaje, en este caso, la posicion X del mouse dentro de la ventana
  myMessage.add(mouseX); 

  // Enviamos el mensaje 
  oscP5.send(myMessage, myRemoteLocation);
}


/* Los mensajes entrantes son reenviados al evento oscEvent. Esta funcion se dispara cada vez que llega un mensaje */
void oscEvent(OscMessage theOscMessage) {
  /* Los mensajes recibidos se imprimen en la consola, en este caso esta preparado para recibir valores de numeros enteros */
  print("### mensaje recibido: ");
  //Comente esta linea si desea recibir otro dato diferente a un int
  print("valor "+theOscMessage.get(0).intValue());
  //Utilice esta linea si desea recibir un valor tipo string
  // print("valor "+theOscMessage.get(0).stringValue());

  //Utilice esta linea si desea recibir un valor tipo float
  // print("valor "+theOscMessage.get(0).floatValue());
  println(" tipo de dato: "+theOscMessage.typetag());
}
