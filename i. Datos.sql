--INSERT de las tablas
EXEC Produccion.agregarDepartamento 'Planificacion', 'En encarga de verificar cada una de las órdenes de trabajo que han ingresado a la empresa, y como su nombre lo dice, planificar todo el proceso productivo de la empresa, esto incluye, verificar el trabajo en proceso en toda la planta, con el objetivo de no asignar más cargas de trabajo de la que se puede tener'
EXEC Produccion.agregarDepartamento 'CAD','Este departamento se encarga principalmente de generar los diferentes patrones de marcadores para cada talla y estilo que se produce dentro de la planta, así como de imprimirlos y hacerlos llegar al departamento de corte para el inicio del ciclo productivo.'
EXEC Produccion.agregarDepartamento 'Corte','Este departamento se encarga directamente de recibir los marcadores impresos generados por CAD para procesarlos, cortar la tela y enviar los paquetes de piezas listas para que sean costuradas.'
EXEC Produccion.agregarDepartamento 'Costura','Se encargan directamente del costurado de las piezas, cabe mencionar que algunas piezas pueden ser costuradas antes o después de algún proceso como el sublimado o el estampado.'
EXEC Produccion.agregarDepartamento 'Bodega','Se encargan de la recepción y el almacenaje de la materia prima utilizada en la producción de las prendas, estos pueden considerarse en dos grandes categorías, Fabric (Tela), y Supplies (Hilos, Cordones, Tintas, etc.)'
EXEC Produccion.agregarDepartamento 'Sublimado','Area de Printing en Tela, este proceso se lleva a cabo en ciertas prendas y estilos seleccionados'
EXEC Produccion.agregarDepartamento 'Serigrafia', 'Área de Estampado en Tela, este proceso se lleva a cabo en ciertas prendas y estilos seleccionado'
EXEC Produccion.agregarDepartamento 'Empaque','Se encarga directamente de la recepción total de las prendas para el embalaje y preparación para el envío, a los clientes, en este paso, se hace la rotulación de los paquetes de acuerdo a la compañía logística que se encargará del transporte de los mismos'
EXEC Produccion.agregarDepartamento 'Control de Calidad','De forma segmentada y casi por cada uno de los procesos, se hace un control de calidad para que la orden pueda ser llevada al siguiente paso del proceso productivo.'
EXEC Produccion.agregarDepartamento 'Recursos Humanos','Se encarga del manejo de la información relativa a los empleados, tiempos de entrada y salida, datos generales, etc'
EXEC Produccion.agregarDepartamento 'Contabilidad','Datos relativos al pago y la autorización de cada una de las transacciones y pagos de salarios, etc'
EXEC Produccion.agregarDepartamento 'Compras','Se encarga de generar y realizar las compras de los insumos para todo el proceso productivo y también de los procesos administrativos en general.'

EXEC Produccion.agregarProcesos 'Order Ready',10,1
EXEC Produccion.agregarProcesos 'Printing Marker',5,2
EXEC Produccion.agregarProcesos 'Marker Ready',15,2
EXEC Produccion.agregarProcesos 'Cutting',5,3 
EXEC Produccion.agregarProcesos 'Sewing line',10,4
EXEC Produccion.agregarProcesos 'Out of Sewing Line',15,4
EXEC Produccion.agregarProcesos 'Ironing',15,4
EXEC Produccion.agregarProcesos 'Screen Printing',15,7
EXEC Produccion.agregarProcesos 'Sublimation',15,7
EXEC Produccion.agregarProcesos 'Quality Assurance',15,9
EXEC Produccion.agregarProcesos 'Ready for Packing',10,9
EXEC Produccion.agregarProcesos 'Packing Ready',10,8
EXEC Produccion.agregarProcesos 'Ready for Shipment',10,8
EXEC Produccion.agregarProcesos 'Shipped',10,8

EXEC Venta.agregarTipoCliente 'Empresa'
EXEC Venta.agregarTipoCliente 'Persona'

EXEC Venta.agregarClientePersona 'Juan Lionel','12345678-9','1234-123456-123-2','Calle las brisas, Av. Chinameca Condominio #4','7321-0998','juanitoLeon@hotmail.com',2
EXEC Venta.agregarClienteEmpresa 'SIMAN Metrocentro','Sucursal de Metrocento, San Salvador','2542-4421','siman.metrocentro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'ST Jack´s Soyapango','Sucursal Unicentro Soyapango','2353-0983','stjacksoyapango@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Picaras Boutique','Sucursal Metrocentro, Cerca de Adidas','2260-3444','picarasboutique@gmail.com',1
EXEC Venta.agregarClientePersona 'Leonardo Edenilson Valle','87654321-9','4321-654231-983-5','Boulevar Constitución, atras de Papa Jonh`s','7293-9432','leoValleBoutique@gmail.com',2
EXEC Venta.agregarClientePersona 'Fernando Roberto Lemus Lemus','01928374-5','3241-028743-876-3','Calle a Apulo, Edificio #45,parcela #40','6023-3212','fernanflores@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Jacarandas','Metrocentro Doceava Etapa, a la par St Jack´s','2200-0332','jacarandasmetro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Carlos Boutique','Plaza Mundo San Salvador, local #53','2999-4322','carlosstyle@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'San Sebastian','Calle a San sebastian, condominio #55, Edificio Rojo','2303-4445','sebastianboutique@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Aqua eco','44 calle 2 Zona 12,Guatemala','2248-6000','AquaEcho@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Style Life','Centro comercial la cascada etapa #1,Local #12','2432-3333','stylelifecascada@gmail.com',1
EXEC Venta.agregarClientePersona 'Erick Alberto Esquivel Cañas','65784390-2','0192-657402-543-8','Calle la utilisima, Departamento de la Paz, en redondel la gloria edificio #1','2222-2223','xErickaec@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Vida Estilizada','Metrosur San Salvador, segunda planta local #99','2893-4444','vidaestilizada@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Dora´s','Galerias San Salvador, 3º nivel, local #12','2390-3333','dorasStyle@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Garage','Galerias San Salvador,Cerca del cine local #41','2533-3339','garageESA@gmail.com',1
EXEC Venta.agregarClientePersona 'Ezequiel Pocho Lavezzi Hernández','65780129-8','8888-444222-443-2','Calle el estante, Cabañas, comercial maria purisima,local #47','6555-3333','ezequielpocho@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Prisma Moda Plaza mundo','Sucursal Plaza Mundo, Etapa 2, local #43','2333-4444','prismamodaPM@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Branson Metrocentro','Sucursal Metrocentro San Salvador, 2 Etapa, por fuente con Starbucks','2333-4779','bransonmetrocentro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Calvin Klein Metrocentro','Sucursal Metrocentro San Salvador, 1 Etapa, por parqueo principal de Metrocentro','2441-4461','calvinKleinmetroSS@gmail.com',1
EXEC Venta.agregarClientePersona 'Jimena Abigail Sanchez Guardado','65748309-2','1432-444090-341-5','Calle a Paseo general Escalón, Edificio Verde Local #1','7442-1223','jimenaAbigail@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Carolina´s','Metrocentro San Salvador,1º Nivel, Local #43','2309-3333','carolinas_bouti@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Tatiana´s','Galerias San Salvador, 2º Etapa, nivel #2, local #55','7203-4452','tatiandesign@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Colegio Don Bosco','Soyapango San Salvador, Calle a plan del pino','2000-1123','colegiodonbosco@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Scotiabank','Metrocentro San Salvador, Enfrente de Restaurante los Cebollines','2633-0110','scotiabankss@gmail.com',1
EXEC Venta.agregarClientePersona 'Kevin Alexander De Bruyne Reyes','23341928-3','5432-345019-245-5','Soyapango San Salvador calle la esperanza, edificio #4, parcela #1','6012-5145','KevinBruyne@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Agua Cristal','San Miguel, El Salvador, Calle la Conquista Edificio Azul','2201-2910','cristalelagua@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'SIMAN Plaza Mundo','Sucursal de Plaza Muno, San Salvador','2549-4421','siman.plazamundo@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'ST Jack´s Metrocentro','Sucursal Metrocentro San Salvador','2883-0983','stjacksometrocentro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Local Boutique','Sucursal Metrocentro, Cerca de ADOC y MD','2940-3414','localboutique@gmail.com',1
EXEC Venta.agregarClientePersona 'Vanessa Alexandra Carranza','87654797-1','0182-654231-983-5','Boulevar Constitución, atras de Pollo Real','7423-9432','carranzastyle@gmail.com',2
EXEC Venta.agregarClientePersona 'Diana Alondra Canales','01928373-0','3241-651029-876-3','Calle a Apulo, Edificio #42,parcela #2','6003-3212','alondracanales@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Las Gemas','Metrocentro Cuarta etapa, a la par de Jacarandas','2212-0342','lasgemasmetro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Antonella Boutique','Metrocentro San Salvador, local #23','2999-0312','antonellasalon@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Sant France','Paseo General Escalón, condominio #15, Edificio Azul','2113-4985','santfrance@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'DollarCity Unicentro Soyapango','Unicentro Soyapango San Salvador, local #40','2093-1000','dollacitysoya@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Gorgeous','Centro comercial la cascada etapa #6,Local #68','2098-3331','Gorgeouscascada@gmail.com',1
EXEC Venta.agregarClientePersona 'Diego Gilberto López Lemus','01294390-2','1254-019402-543-8','Calle la hacienda, Departamento de San Miguel, en redondel la esperanza edificio #4','2999-6210','diegopresa@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Star Style','MetroNorte San Salvador, tercera planta local #68','2084-3415','Starstyle@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Carabana´s','Galerias San Salvador, 1º nivel, local #10','2093-7313','carabanaSS@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Mega Variety','Plaza Mundo San Salvador, 2º etapa,local #22','2028-4218','mevarietyPM@gmail.com',1
EXEC Venta.agregarClientePersona 'Filipe Ousmane Hernández Capilla','01829300-8','5017-444222-107-2','Calle la sucia, La unión, comercial maria santisima,local 2','7102-6666','ousmandembele@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Prisma Moda Galerias','Sucursal Galerias, Etapa 1, local #9','2546-0002','prismamodaGAL@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Branson La cascada','Sucursal La Cascada San Salvador, 1 Etapa,por la pizza Hut, local #4','2019-2019','bransoncascada@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Calvin Klein Galerias','Sucursal Galerias San Salvador, 3 Nivel, por salida de parqueo principal','2545-2543','calvinKleingalerias@gmail.com',1
EXEC Venta.agregarClientePersona 'Tomas Alexander Madrid Versa','36451026-2','1432-000192-415-5','Calle a Paseo general Escalón, por plaza Agua pura, Edificio #2, local #41','6442-1302','versamadriddecima@gmail.com',2
EXEC Venta.agregarClienteEmpresa 'Central´s','Metrocentro San Salvador,2º Nivel, Local #66','2098-4133','centralsdress@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Dresess Karla','Galerias San Salvador, 1º Etapa, nivel #1, frente a Samsung','7102-4210','dresseskarl@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Elegance boutique','Soyapango San Salvador, Calle a Plaza mundo, a la par del Pollo Campero','2534-7356','eleganceboutiquess@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Puma Metrocentro','Metrocentro San Salvador, A la par de Restaurante los Cebollines','2309-1221','pumasmetro@gmail.com',1
EXEC Venta.agregarClienteEmpresa 'Elegance T-Shirt','Galerias San salvador, local #22 nivel #4, a la par de Calvin Klein','2120-3313','elegandeshirt@gmail.com',1

EXEC Produccion.agregarMetodologia 'Normal'
EXEC Produccion.agregarMetodologia 'Fasttrack'

EXEC Produccion.agregarModulo 'Módulo 1', 400,1
EXEC Produccion.agregarModulo 'Módulo 2', 300,1
EXEC Produccion.agregarModulo 'Módulo 3', 300,1
EXEC Produccion.agregarModulo 'Módulo 4', 300,1
EXEC Produccion.agregarModulo 'Módulo 5', 200,1
EXEC Produccion.agregarModulo 'Módulo 6', 250,1
EXEC Produccion.agregarModulo 'Módulo 7', 200,1
EXEC Produccion.agregarModulo 'Módulo 8', 150,1
EXEC Produccion.agregarModulo 'Módulo 9', 300,1
EXEC Produccion.agregarModulo 'Módulo 10', 300,1
EXEC Produccion.agregarModulo 'FastTrack',125,2

EXEC Venta.agregarFactura '2018-06-23','2018-05-02','2018-06-08','2018-06-09','Calle las brisas, Av. Chinameca Condominio #4',1
EXEC Venta.agregarFactura '2018-06-25','2018-05-07','2018-06-10','2018-06-11','Sucursal de Metrocento, San Salvador',2
EXEC Venta.agregarFactura '2018-06-21','2018-05-05','2018-06-06','2018-06-07','Sucursal Unicentro Soyapango',3
EXEC Venta.agregarFactura '2018-06-24','2018-05-01','2018-06-09','2018-06-10','Sucursal Metrocentro, Cerca de Adidas',4
EXEC Venta.agregarFactura '2018-06-20','2018-05-06','2018-06-05','2018-06-06','Boulevar Constitución, atras de Papa Jonh`s',5
EXEC Venta.agregarFactura '2018-06-29','2018-05-05','2018-06-14','2018-06-15','Calle a Apulo, Edificio #45,parcela #40',6
EXEC Venta.agregarFactura '2018-06-24','2018-05-03','2018-06-09','2018-06-10','Metrocentro Doceava Etapa, a la par St Jack´s',7
EXEC Venta.agregarFactura '2018-06-23','2018-05-02','2018-06-08','2018-06-09','Plaza Mundo San Salvador, local #53',8
EXEC Venta.agregarFactura '2018-06-27','2018-05-10','2018-06-12','2018-06-13','Calle a San sebastian, condominio #55, Edificio Rojo',9
EXEC Venta.agregarFactura '2018-06-21','2018-05-08','2018-06-06','2018-06-07','44 calle 2 Zona 12,Guatemala',10
EXEC Venta.agregarFactura '2018-06-20','2018-05-10','2018-06-05','2018-06-06','Centro comercial la cascada etapa #1,Local #12',11
EXEC Venta.agregarFactura '2018-06-18','2018-05-11','2018-06-03','2018-06-04','Calle la utilisima, Departamento de la Paz, en redondel la gloria edificio #1',12
EXEC Venta.agregarFactura '2018-06-16','2018-05-08','2018-06-01','2018-06-02','Metrosur San Salvador, segunda planta local #99',13
EXEC Venta.agregarFactura '2018-06-28','2018-05-02','2018-06-13','2018-06-14','Galerias San Salvador, 3º nivel, local #12',14
EXEC Venta.agregarFactura '2018-06-23','2018-05-08','2018-06-08','2018-06-09','Galerias San Salvador,Cerca del cine local #41',15
EXEC Venta.agregarFactura '2018-06-17','2018-05-02','2018-06-02','2018-06-03','Calle el estante, Cabañas, comercial maria purisima,local #47',16
EXEC Venta.agregarFactura '2018-06-20','2018-05-07','2018-06-05','2018-06-06','Sucursal Plaza Mundo, Etapa 2, local #43',17
EXEC Venta.agregarFactura '2018-06-20','2018-05-03','2018-06-05','2018-06-06','Sucursal Metrocentro San Salvador, 2 Etapa, por fuente con Starbucks',18
EXEC Venta.agregarFactura '2018-06-30','2018-05-07','2018-06-15','2018-06-16','Sucursal Metrocentro San Salvador, 1 Etapa, por parqueo principal de Metrocentro',19
EXEC Venta.agregarFactura '2018-06-24','2018-05-06','2018-06-09','2018-06-10','Calle a Paseo general Escalón, Edificio Verde Local #1',20
EXEC Venta.agregarFactura '2018-06-02','2018-05-03','2018-05-18','2018-05-19','Metrocentro San Salvador,1º Nivel, Local #43',21
EXEC Venta.agregarFactura '2018-06-01','2018-05-02','2018-05-17','2018-05-18','Galerias San Salvador, 2º Etapa, nivel #2, local #55',22
EXEC Venta.agregarFactura '2018-06-27','2018-05-02','2018-06-12','2018-06-13','Soyapango San Salvador, Calle a plan del pino',23
EXEC Venta.agregarFactura '2018-06-26','2018-05-02','2018-06-11','2018-06-12','Metrocentro San Salvador, Enfrente de Restaurante los Cebollines',24
EXEC Venta.agregarFactura '2018-06-25','2018-05-01','2018-06-10','2018-06-11','Soyapango San Salvador calle la esperanza, edificio #4, parcela #1',25
EXEC Venta.agregarFactura '2018-06-26','2018-05-08','2018-06-11','2018-06-12','San Miguel, El Salvador, Calle la Conquista Edificio Azul',26--otro
EXEC Venta.agregarFactura '2018-06-28','2018-05-07','2018-06-13','2018-06-14','Sucursal de Plaza Mundo, San Salvador',27
EXEC Venta.agregarFactura '2018-06-26','2018-05-10','2018-06-11','2018-06-12','Sucursal Metrocentro San Salvador',28
EXEC Venta.agregarFactura '2018-06-20','2018-05-07','2018-06-05','2018-06-06','Sucursal Metrocentro, Cerca de ADOC y MD',29
EXEC Venta.agregarFactura '2018-06-21','2018-05-08','2018-06-06','2018-06-07','Boulevar Constitución, atras de Pollo Real',30
EXEC Venta.agregarFactura '2018-06-17','2018-05-06','2018-06-02','2018-06-03','Calle a Apulo, Edificio #42,parcela #2',31
EXEC Venta.agregarFactura '2018-06-25','2018-05-10','2018-06-10','2018-06-11','Metrocentro Cuarta etapa, a la par de Jacarandas',32
EXEC Venta.agregarFactura '2018-06-20','2018-05-07','2018-06-05','2018-06-06','Metrocentro San Salvador, local #23',33
EXEC Venta.agregarFactura '2018-06-19','2018-05-10','2018-06-04','2018-06-05','Paseo General Escalón, condominio #15, Edificio Azul',34
EXEC Venta.agregarFactura '2018-06-18','2018-05-11','2018-06-03','2018-06-04','Unicentro Soyapango San Salvador, local #40',35
EXEC Venta.agregarFactura '2018-06-16','2018-05-03','2018-06-01','2018-06-02','Centro comercial la cascada etapa #6,Local #68',36
EXEC Venta.agregarFactura '2018-06-20','2018-05-07','2018-06-05','2018-06-06','Calle la hacienda, Departamento de San Miguel, en redondel la esperanza edificio #4',37
EXEC Venta.agregarFactura '2018-06-15','2018-05-01','2018-05-31','2018-06-01','MetroNorte San Salvador, tercera planta local #68',38
EXEC Venta.agregarFactura '2018-06-16','2018-05-02','2018-06-01','2018-06-02','Galerias San Salvador, 1º nivel, local #10',39
EXEC Venta.agregarFactura '2018-06-26','2018-05-08','2018-06-11','2018-06-12','Plaza Mundo San Salvador, 2º etapa,local #22',40
EXEC Venta.agregarFactura '2018-06-21','2018-05-02','2018-06-06','2018-06-07','Calle la sucia, La unión, comercial maria santisima,local 2',41
EXEC Venta.agregarFactura '2018-06-26','2018-05-11','2018-06-11','2018-06-12','Sucursal Galerias, Etapa 1, local #9',42
EXEC Venta.agregarFactura '2018-06-13','2018-05-02','2018-05-29','2018-05-30','Sucursal La Cascada San Salvador, 1 Etapa,por la pizza Hut, local #4',43
EXEC Venta.agregarFactura '2018-06-28','2018-05-01','2018-06-13','2018-06-14','Sucursal Galerias San Salvador, 3 Nivel, por salida de parqueo principal',44
EXEC Venta.agregarFactura '2018-07-21','2018-05-11','2018-07-06','2018-07-07','Calle a Paseo general Escalón, por plaza Agua pura, Edificio #2, local #41',45
EXEC Venta.agregarFactura '2018-06-22','2018-05-03','2018-06-07','2018-06-08','Metrocentro San Salvador,2º Nivel, Local #66',46
EXEC Venta.agregarFactura '2018-06-27','2018-05-10','2018-06-12','2018-06-13','Galerias San Salvador, 1º Etapa, nivel #1, frente a Samsung',47
EXEC Venta.agregarFactura '2018-06-16','2018-05-09','2018-06-01','2018-06-02','Soyapango San Salvador, Calle a Plaza mundo, a la par del Pollo Campero',48
EXEC Venta.agregarFactura '2018-07-15','2018-05-11','2018-06-30','2018-07-01','Metrocentro San Salvador, A la par de Restaurante los Cebollines',49
EXEC Venta.agregarFactura '2018-06-20','2018-05-06','2018-06-05','2018-06-06','Galerias San salvador, local #22 nivel #4, a la par de Calvin Klein',50

EXEC Produccion.agregarTipoVariante 'BLANKS'
EXEC Produccion.agregarTipoVariante 'SCREEN PRINTING'
EXEC Produccion.agregarTipoVariante 'SUBLIMATION'

EXEC Produccion.agregarDetalles 'Pecho Completo',0.75,8 
EXEC Produccion.agregarDetalles 'Pecho Derecho',0.55,8
EXEC Produccion.agregarDetalles 'Manga Derecha',0.55,8
EXEC Produccion.agregarDetalles 'Manga Izquierda',0.55,8
EXEC Produccion.agregarDetalles 'Espalda',0.75,8
EXEC Produccion.agregarDetalles 'Sublimado',2.25,9

EXEC Produccion.agregarVarianteDetalle 2,1
EXEC Produccion.agregarVarianteDetalle 2,2
EXEC Produccion.agregarVarianteDetalle 2,3
EXEC Produccion.agregarVarianteDetalle 2,4
EXEC Produccion.agregarVarianteDetalle 2,5
EXEC Produccion.agregarVarianteDetalle 3,6

EXEC Produccion.agregarFlujoTrabajo 1
EXEC Produccion.agregarFlujoTrabajo 2
EXEC Produccion.agregarFlujoTrabajo 3

EXEC Produccion.agregarFlujoProceso 1, 1
EXEC Produccion.agregarFlujoProceso 1, 2
EXEC Produccion.agregarFlujoProceso 1, 3
EXEC Produccion.agregarFlujoProceso 1, 4
EXEC Produccion.agregarFlujoProceso 1, 5
EXEC Produccion.agregarFlujoProceso 1, 6
EXEC Produccion.agregarFlujoProceso 1, 7
EXEC Produccion.agregarFlujoProceso 1, 10
EXEC Produccion.agregarFlujoProceso 1, 11
EXEC Produccion.agregarFlujoProceso 1, 12
EXEC Produccion.agregarFlujoProceso 1, 13
EXEC Produccion.agregarFlujoProceso 1, 14
EXEC Produccion.agregarFlujoProceso 2, 2
EXEC Produccion.agregarFlujoProceso 2, 3
EXEC Produccion.agregarFlujoProceso 2, 4
EXEC Produccion.agregarFlujoProceso 2, 5
EXEC Produccion.agregarFlujoProceso 2, 6
EXEC Produccion.agregarFlujoProceso 2, 7
EXEC Produccion.agregarFlujoProceso 2, 8
EXEC Produccion.agregarFlujoProceso 2, 10
EXEC Produccion.agregarFlujoProceso 2, 11
EXEC Produccion.agregarFlujoProceso 2, 12
EXEC Produccion.agregarFlujoProceso 2, 13
EXEC Produccion.agregarFlujoProceso 2, 14
EXEC Produccion.agregarFlujoProceso 3, 2
EXEC Produccion.agregarFlujoProceso 3, 3
EXEC Produccion.agregarFlujoProceso 3, 4
EXEC Produccion.agregarFlujoProceso 3, 5
EXEC Produccion.agregarFlujoProceso 3, 6
EXEC Produccion.agregarFlujoProceso 3, 7
EXEC Produccion.agregarFlujoProceso 3, 9
EXEC Produccion.agregarFlujoProceso 3, 10
EXEC Produccion.agregarFlujoProceso 3, 11
EXEC Produccion.agregarFlujoProceso 3, 12
EXEC Produccion.agregarFlujoProceso 3, 13
EXEC Produccion.agregarFlujoProceso 3, 14

EXEC Produccion.agregarEstadoSeguimiento 'En proceso'
EXEC Produccion.agregarEstadoSeguimiento 'Finalizado'
EXEC Produccion.agregarEstadoSeguimiento 'Pendiente'

EXEC Produccion.agregarEstadoOrden 'En proceso'
EXEC Produccion.agregarEstadoOrden 'Finalizado'
EXEC Produccion.agregarEstadoOrden 'Pendiente'

EXEC Producto.agregarPrenda 'Camisa',5.75
EXEC Producto.agregarPrenda 'Pantalon',8.75
EXEC Producto.agregarPrenda 'Suéter',11.75
EXEC Producto.agregarPrenda 'Sudadera',11.75
EXEC Producto.agregarPrenda 'Corbata',3.75
EXEC Producto.agregarPrenda 'Camisa sin Manga',5.25
EXEC Producto.agregarPrenda 'Camisa de Vestir Manga Larga',10.00
EXEC Producto.agregarPrenda 'Pantalones Cortos',8.50

EXEC Producto.agregarEstilo 'HJ320',1
EXEC Producto.agregarEstilo 'AD560',1
EXEC Producto.agregarEstilo 'FG200',1
EXEC Producto.agregarEstilo 'CL120',1
EXEC Producto.agregarEstilo 'KL620',1
EXEC Producto.agregarEstilo 'PO200',1
EXEC Producto.agregarEstilo 'JK690',1
EXEC Producto.agregarEstilo 'MN470',1
EXEC Producto.agregarEstilo 'HY650',1
EXEC Producto.agregarEstilo 'DE589',2
EXEC Producto.agregarEstilo 'ZA894',2
EXEC Producto.agregarEstilo 'BG659',2
EXEC Producto.agregarEstilo 'UI895',2
EXEC Producto.agregarEstilo 'NH123',2
EXEC Producto.agregarEstilo 'MJ698',2
EXEC Producto.agregarEstilo 'BG548',2
EXEC Producto.agregarEstilo 'NH698',2
EXEC Producto.agregarEstilo 'GH548',2
EXEC Producto.agregarEstilo 'JK659',2
EXEC Producto.agregarEstilo 'VP548',3
EXEC Producto.agregarEstilo 'AE781',3
EXEC Producto.agregarEstilo 'SW453',3
EXEC Producto.agregarEstilo 'DP890',3
EXEC Producto.agregarEstilo 'WN751',3
EXEC Producto.agregarEstilo 'IK587',3
EXEC Producto.agregarEstilo 'TY548',3
EXEC Producto.agregarEstilo 'ER321',3
EXEC Producto.agregarEstilo 'HY985',3
EXEC Producto.agregarEstilo 'CF489',3
EXEC Producto.agregarEstilo 'QP501',4
EXEC Producto.agregarEstilo 'PB283',4
EXEC Producto.agregarEstilo 'CU348',4
EXEC Producto.agregarEstilo 'QL569',4
EXEC Producto.agregarEstilo 'PB582',4
EXEC Producto.agregarEstilo 'AL573',4
EXEC Producto.agregarEstilo 'MU891',4
EXEC Producto.agregarEstilo 'KV528',4
EXEC Producto.agregarEstilo 'RG243',4
EXEC Producto.agregarEstilo 'LP189',4
EXEC Producto.agregarEstilo 'MI854',5
EXEC Producto.agregarEstilo 'NJ128',5
EXEC Producto.agregarEstilo 'OP589',5
EXEC Producto.agregarEstilo 'GT548',5
EXEC Producto.agregarEstilo 'OV259',5
EXEC Producto.agregarEstilo 'ER028',5
EXEC Producto.agregarEstilo 'BHT58',5
EXEC Producto.agregarEstilo 'NQ145',5
EXEC Producto.agregarEstilo 'UD574',5
EXEC Producto.agregarEstilo 'QD147',5

EXEC Producto.agregarTipoTalla 'small','S'
exec Producto.agregarTipoTalla @nombre = 'Medium', @abreviacion = 'M'
exec Producto.agregarTipoTalla @nombre = 'Large', @abreviacion = 'L'
exec Producto.agregarTipoTalla @nombre = 'Extra large', @abreviacion = 'XL'
exec Producto.agregarTipoTalla @nombre = 'Extra extra small', @abreviacion = '2XS'
exec Producto.agregarTipoTalla @nombre = 'Extra small', @abreviacion = 'XS'
exec Producto.agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '2XL'
exec Producto.agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '3XL'
exec Producto.agregarTipoTalla @nombre = 'Extra extra large', @abreviacion = '4XL'

exec Producto.agregarUbicacion @ubicacion = 'Pecho'
exec Producto.agregarUbicacion @ubicacion = 'Cintura'
exec Producto.agregarUbicacion @ubicacion = 'Trasero'
exec Producto.agregarUbicacion @ubicacion = 'Tiro' 
exec Producto.agregarUbicacion @ubicacion = 'Manga' 
exec Producto.agregarUbicacion @ubicacion = 'Costura interior'
exec Producto.agregarUbicacion @ubicacion = 'Largo pantalon' 
exec Producto.agregarUbicacion @ubicacion = 'Ancho espalda'
exec Producto.agregarUbicacion @ubicacion = 'Talle espalda'
exec Producto.agregarUbicacion @ubicacion = 'Cuello'
exec Producto.agregarUbicacion @ubicacion = 'Entrepierna'
exec Producto.agregarUbicacion @ubicacion = 'Manga corta'
exec Producto.agregarUbicacion @ubicacion = 'Largo rodilla'
exec Producto.agregarUbicacion @ubicacion = 'Contorno rodilla'
exec Producto.agregarUbicacion @ubicacion = 'Cadera'
exec Producto.agregarUbicacion @ubicacion = 'Largo camisa'
exec Producto.agregarUbicacion @ubicacion = 'Manga larga'

exec Producto.agregarUbicacion @ubicacion = 'Ancho superior corbata'
exec Producto.agregarUbicacion @ubicacion = 'largo corbata'
exec Producto.agregarUbicacion @ubicacion = 'ancho inferior corbata'

EXEC Producto.agregarTalla 1.00,1,1,1 --Aqui debe coincidir con los registro del PDF
exec Producto.agregarTalla @cantidadTela = 1.25, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 1
exec Producto.agregarTalla @cantidadTela = 1.50, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 1
exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 1

exec Producto.agregarTalla @cantidadTela = 1.50, @idTipoTalla = 1,@idPrenda = 2, @idEstilo = 2
exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 2
exec Producto.agregarTalla @cantidadTela = 1.90, @idTipoTalla = 3,@idPrenda = 2, @idEstilo = 2
exec Producto.agregarTalla @cantidadTela = 2.10, @idTipoTalla = 4,@idPrenda = 2, @idEstilo = 2

exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 1,@idPrenda = 3, @idEstilo = 3
exec Producto.agregarTalla @cantidadTela = 1.95, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 3
exec Producto.agregarTalla @cantidadTela = 2.15, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 3
exec Producto.agregarTalla @cantidadTela = 2.35, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 3

exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 4
exec Producto.agregarTalla @cantidadTela = 1.95, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 4
exec Producto.agregarTalla @cantidadTela = 2.15, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 4
exec Producto.agregarTalla @cantidadTela = 2.35, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 4

exec Producto.agregarTalla @cantidadTela = 1.18, @idTipoTalla = 1,@idPrenda = 5, @idEstilo = 5
exec Producto.agregarTalla @cantidadTela = 1.63, @idTipoTalla = 2,@idPrenda = 5, @idEstilo = 5
exec Producto.agregarTalla @cantidadTela = 2.59, @idTipoTalla = 3,@idPrenda = 5, @idEstilo = 5
exec Producto.agregarTalla @cantidadTela = 1.77, @idTipoTalla = 4,@idPrenda = 5, @idEstilo = 5

exec Producto.agregarTalla @cantidadTela = 1.78, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 6
exec Producto.agregarTalla @cantidadTela = 2.89, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 6
exec Producto.agregarTalla @cantidadTela = 1.22, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 6
exec Producto.agregarTalla @cantidadTela = 1.78, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 6

exec Producto.agregarTalla @cantidadTela = 1.29, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 7
exec Producto.agregarTalla @cantidadTela = 2.67, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 7
exec Producto.agregarTalla @cantidadTela = 1.71, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 7
exec Producto.agregarTalla @cantidadTela = 1.49, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 7

exec Producto.agregarTalla @cantidadTela = 1.05, @idTipoTalla = 1,@idPrenda = 5, @idEstilo = 8
exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 2,@idPrenda = 5, @idEstilo = 8
exec Producto.agregarTalla @cantidadTela = 2.28, @idTipoTalla = 3,@idPrenda = 5, @idEstilo = 8
exec Producto.agregarTalla @cantidadTela = 1.10, @idTipoTalla = 4,@idPrenda = 5, @idEstilo = 8

exec Producto.agregarTalla @cantidadTela = 1.95, @idTipoTalla = 1,@idPrenda = 2, @idEstilo = 9
exec Producto.agregarTalla @cantidadTela = 1.92, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 9
exec Producto.agregarTalla @cantidadTela = 2.47, @idTipoTalla = 3,@idPrenda = 2, @idEstilo = 9
exec Producto.agregarTalla @cantidadTela = 1.03, @idTipoTalla = 4,@idPrenda = 2, @idEstilo = 9

exec Producto.agregarTalla @cantidadTela = 2.50, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 10
exec Producto.agregarTalla @cantidadTela = 1.55, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 10
exec Producto.agregarTalla @cantidadTela = 1.09, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 10
exec Producto.agregarTalla @cantidadTela = 1.88, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 10

exec Producto.agregarTalla @cantidadTela = 1.82, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 11
exec Producto.agregarTalla @cantidadTela = 1.09, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 11
exec Producto.agregarTalla @cantidadTela = 1.90, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 11
exec Producto.agregarTalla @cantidadTela = 2.81, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 11

exec Producto.agregarTalla @cantidadTela = 1.43, @idTipoTalla = 1,@idPrenda = 2, @idEstilo = 12
exec Producto.agregarTalla @cantidadTela = 1.91, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 12
exec Producto.agregarTalla @cantidadTela = 2.76, @idTipoTalla = 3,@idPrenda = 2, @idEstilo = 12
exec Producto.agregarTalla @cantidadTela = 1.03, @idTipoTalla = 4,@idPrenda = 2, @idEstilo = 12

exec Producto.agregarTalla @cantidadTela = 1.55, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 13
exec Producto.agregarTalla @cantidadTela = 1.71, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 13
exec Producto.agregarTalla @cantidadTela = 2.50, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 13
exec Producto.agregarTalla @cantidadTela = 1.91, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 13

exec Producto.agregarTalla @cantidadTela = 1.05, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 14
exec Producto.agregarTalla @cantidadTela = 1.08, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 14
exec Producto.agregarTalla @cantidadTela = 1.92, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 14
exec Producto.agregarTalla @cantidadTela = 1.47, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 14

exec Producto.agregarTalla @cantidadTela = 1.13, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 15
exec Producto.agregarTalla @cantidadTela = 1.71, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 15
exec Producto.agregarTalla @cantidadTela = 1.01, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 15
exec Producto.agregarTalla @cantidadTela = 2.60, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 15

exec Producto.agregarTalla @cantidadTela = 2.17, @idTipoTalla = 1,@idPrenda = 3, @idEstilo = 16
exec Producto.agregarTalla @cantidadTela = 2.62, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 16
exec Producto.agregarTalla @cantidadTela = 1.01, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 16
exec Producto.agregarTalla @cantidadTela = 1.32, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 16

exec Producto.agregarTalla @cantidadTela = 1.34, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 17
exec Producto.agregarTalla @cantidadTela = 1.57, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 17
exec Producto.agregarTalla @cantidadTela = 1.67, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 17
exec Producto.agregarTalla @cantidadTela = 2.13, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 17

exec Producto.agregarTalla @cantidadTela = 1.18, @idTipoTalla = 1,@idPrenda = 5, @idEstilo = 18
exec Producto.agregarTalla @cantidadTela = 2.95, @idTipoTalla = 2,@idPrenda = 5, @idEstilo = 18
exec Producto.agregarTalla @cantidadTela = 1.98, @idTipoTalla = 3,@idPrenda = 5, @idEstilo = 18
exec Producto.agregarTalla @cantidadTela = 2.90, @idTipoTalla = 4,@idPrenda = 5, @idEstilo = 18

exec Producto.agregarTalla @cantidadTela = 1.22, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 19
exec Producto.agregarTalla @cantidadTela = 1.36, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 19
exec Producto.agregarTalla @cantidadTela = 1.07, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 19
exec Producto.agregarTalla @cantidadTela = 2.39, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 19

exec Producto.agregarTalla @cantidadTela = 1.96, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 20
exec Producto.agregarTalla @cantidadTela = 1.04, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 20
exec Producto.agregarTalla @cantidadTela = 1.13, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 20
exec Producto.agregarTalla @cantidadTela = 1.74, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 20

exec Producto.agregarTalla @cantidadTela = 1.41, @idTipoTalla = 1,@idPrenda = 3, @idEstilo = 21
exec Producto.agregarTalla @cantidadTela = 2.36, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 21
exec Producto.agregarTalla @cantidadTela = 1.56, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 21
exec Producto.agregarTalla @cantidadTela = 1.63, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 21

exec Producto.agregarTalla @cantidadTela = 1.63, @idTipoTalla = 1,@idPrenda = 5, @idEstilo = 22
exec Producto.agregarTalla @cantidadTela = 1.31, @idTipoTalla = 2,@idPrenda = 5, @idEstilo = 22
exec Producto.agregarTalla @cantidadTela = 1.68, @idTipoTalla = 3,@idPrenda = 5, @idEstilo = 22
exec Producto.agregarTalla @cantidadTela = 1.62, @idTipoTalla = 4,@idPrenda = 5, @idEstilo = 22

exec Producto.agregarTalla @cantidadTela = 1.82, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 23
exec Producto.agregarTalla @cantidadTela = 1.89, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 23
exec Producto.agregarTalla @cantidadTela = 1.81, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 23
exec Producto.agregarTalla @cantidadTela = 1.43, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 23

exec Producto.agregarTalla @cantidadTela = 1.68, @idTipoTalla = 1,@idPrenda = 3, @idEstilo = 24
exec Producto.agregarTalla @cantidadTela = 2.70, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 24
exec Producto.agregarTalla @cantidadTela = 1.21, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 24
exec Producto.agregarTalla @cantidadTela = 1.56, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 24

exec Producto.agregarTalla @cantidadTela = 2.76, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 25
exec Producto.agregarTalla @cantidadTela = 1.86, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 25
exec Producto.agregarTalla @cantidadTela = 1.03, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 25
exec Producto.agregarTalla @cantidadTela = 1.57, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 25

exec Producto.agregarTalla @cantidadTela = 2.28, @idTipoTalla = 1,@idPrenda = 2, @idEstilo = 26
exec Producto.agregarTalla @cantidadTela = 2.50, @idTipoTalla = 2,@idPrenda = 2, @idEstilo = 26
exec Producto.agregarTalla @cantidadTela = 1.28, @idTipoTalla = 3,@idPrenda = 2, @idEstilo = 26
exec Producto.agregarTalla @cantidadTela = 1.22, @idTipoTalla = 4,@idPrenda = 2, @idEstilo = 26

exec Producto.agregarTalla @cantidadTela = 1.43, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 27
exec Producto.agregarTalla @cantidadTela = 2.25, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 27
exec Producto.agregarTalla @cantidadTela = 1.67, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 27
exec Producto.agregarTalla @cantidadTela = 2.47, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 27

exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 28
exec Producto.agregarTalla @cantidadTela = 1.43, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 28
exec Producto.agregarTalla @cantidadTela = 1.93, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 28
exec Producto.agregarTalla @cantidadTela = 1.54, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 28

exec Producto.agregarTalla @cantidadTela = 1.05, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 29
exec Producto.agregarTalla @cantidadTela = 2.60, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 29
exec Producto.agregarTalla @cantidadTela = 1.83, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 29
exec Producto.agregarTalla @cantidadTela = 2.14, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 29

exec Producto.agregarTalla @cantidadTela = 2.36, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 30
exec Producto.agregarTalla @cantidadTela = 2.82, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 30
exec Producto.agregarTalla @cantidadTela = 2.25, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 30
exec Producto.agregarTalla @cantidadTela = 2.46, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 30

exec Producto.agregarTalla @cantidadTela = 1.23, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 31
exec Producto.agregarTalla @cantidadTela = 1.66, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 31
exec Producto.agregarTalla @cantidadTela = 1.46, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 31
exec Producto.agregarTalla @cantidadTela = 2.67, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 31

exec Producto.agregarTalla @cantidadTela = 2.61, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 32
exec Producto.agregarTalla @cantidadTela = 2.63, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 32
exec Producto.agregarTalla @cantidadTela = 2.26, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 32
exec Producto.agregarTalla @cantidadTela = 1.59, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 32

exec Producto.agregarTalla @cantidadTela = 2.33, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 33
exec Producto.agregarTalla @cantidadTela = 1.35, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 33
exec Producto.agregarTalla @cantidadTela = 1.61, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 33
exec Producto.agregarTalla @cantidadTela = 1.09, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 33

exec Producto.agregarTalla @cantidadTela = 2.22, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 34
exec Producto.agregarTalla @cantidadTela = 2.69, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 34
exec Producto.agregarTalla @cantidadTela = 1.38, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 34
exec Producto.agregarTalla @cantidadTela = 1.60, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 34

exec Producto.agregarTalla @cantidadTela = 1.11, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 35
exec Producto.agregarTalla @cantidadTela = 1.76, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 35
exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 35
exec Producto.agregarTalla @cantidadTela = 1.22, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 35

exec Producto.agregarTalla @cantidadTela = 1.04, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 36
exec Producto.agregarTalla @cantidadTela = 1.15, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 36
exec Producto.agregarTalla @cantidadTela = 1.23, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 36
exec Producto.agregarTalla @cantidadTela = 1.77, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 36

exec Producto.agregarTalla @cantidadTela = 1.72, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 37
exec Producto.agregarTalla @cantidadTela = 2.40, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 37
exec Producto.agregarTalla @cantidadTela = 1.81, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 37
exec Producto.agregarTalla @cantidadTela = 1.54, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 37

exec Producto.agregarTalla @cantidadTela = 1.07, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 38
exec Producto.agregarTalla @cantidadTela = 1.28, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 38
exec Producto.agregarTalla @cantidadTela = 1.01, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 38
exec Producto.agregarTalla @cantidadTela = 1.80, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 38

exec Producto.agregarTalla @cantidadTela = 1.35, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 39
exec Producto.agregarTalla @cantidadTela = 1.20, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 39
exec Producto.agregarTalla @cantidadTela = 1.99, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 39
exec Producto.agregarTalla @cantidadTela = 1.71, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 39

exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 40
exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 40
exec Producto.agregarTalla @cantidadTela = 1.77, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 40
exec Producto.agregarTalla @cantidadTela = 1.14, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 40

exec Producto.agregarTalla @cantidadTela = 1.06, @idTipoTalla = 1,@idPrenda = 3, @idEstilo = 41
exec Producto.agregarTalla @cantidadTela = 1.33, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 41
exec Producto.agregarTalla @cantidadTela = 1.86, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 41
exec Producto.agregarTalla @cantidadTela = 1.14, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 41

exec Producto.agregarTalla @cantidadTela = 1.91, @idTipoTalla = 1,@idPrenda = 4, @idEstilo = 42
exec Producto.agregarTalla @cantidadTela = 1.12, @idTipoTalla = 2,@idPrenda = 4, @idEstilo = 42
exec Producto.agregarTalla @cantidadTela = 2.14, @idTipoTalla = 3,@idPrenda = 4, @idEstilo = 42
exec Producto.agregarTalla @cantidadTela = 1.42, @idTipoTalla = 4,@idPrenda = 4, @idEstilo = 42

exec Producto.agregarTalla @cantidadTela = 1.75, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 43
exec Producto.agregarTalla @cantidadTela = 1.14, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 43
exec Producto.agregarTalla @cantidadTela = 2.73, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 43
exec Producto.agregarTalla @cantidadTela = 1.83, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 43

exec Producto.agregarTalla @cantidadTela = 1.35, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 44
exec Producto.agregarTalla @cantidadTela = 1.99, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 44
exec Producto.agregarTalla @cantidadTela = 2.20, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 44
exec Producto.agregarTalla @cantidadTela = 1.36, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 44

exec Producto.agregarTalla @cantidadTela = 1.70, @idTipoTalla = 1,@idPrenda = 7, @idEstilo = 45
exec Producto.agregarTalla @cantidadTela = 1.79, @idTipoTalla = 2,@idPrenda = 7, @idEstilo = 45
exec Producto.agregarTalla @cantidadTela = 1.02, @idTipoTalla = 3,@idPrenda = 7, @idEstilo = 45
exec Producto.agregarTalla @cantidadTela = 1.08, @idTipoTalla = 4,@idPrenda = 7, @idEstilo = 45

exec Producto.agregarTalla @cantidadTela = 1.93, @idTipoTalla = 1,@idPrenda = 6, @idEstilo = 46
exec Producto.agregarTalla @cantidadTela = 2.33, @idTipoTalla = 2,@idPrenda = 6, @idEstilo = 46
exec Producto.agregarTalla @cantidadTela = 1.97, @idTipoTalla = 3,@idPrenda = 6, @idEstilo = 46
exec Producto.agregarTalla @cantidadTela = 1.51, @idTipoTalla = 4,@idPrenda = 6, @idEstilo = 46

exec Producto.agregarTalla @cantidadTela = 1.55, @idTipoTalla = 1,@idPrenda = 1, @idEstilo = 47
exec Producto.agregarTalla @cantidadTela = 2.35, @idTipoTalla = 2,@idPrenda = 1, @idEstilo = 47
exec Producto.agregarTalla @cantidadTela = 1.93, @idTipoTalla = 3,@idPrenda = 1, @idEstilo = 47
exec Producto.agregarTalla @cantidadTela = 1.97, @idTipoTalla = 4,@idPrenda = 1, @idEstilo = 47

exec Producto.agregarTalla @cantidadTela = 1.00, @idTipoTalla = 1,@idPrenda = 3, @idEstilo = 48
exec Producto.agregarTalla @cantidadTela = 1.71, @idTipoTalla = 2,@idPrenda = 3, @idEstilo = 48
exec Producto.agregarTalla @cantidadTela = 1.77, @idTipoTalla = 3,@idPrenda = 3, @idEstilo = 48
exec Producto.agregarTalla @cantidadTela = 2.60, @idTipoTalla = 4,@idPrenda = 3, @idEstilo = 48

-- Camisa --
EXEC Producto.agregarMedida 86.5,1,1
exec Producto.agregarMedida @dimension = 36, @idTalla = 1, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 72, @idTalla = 1, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 25, @idTalla = 1, @idUbicacion = 17

-- Pantalon --
EXEC Producto.agregarMedida 30.5,2,1
exec Producto.agregarMedida @dimension = 40, @idTalla = 2, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 80, @idTalla = 2, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 53, @idTalla = 2, @idUbicacion = 12

-- Sueter--
exec Producto.agregarMedida @dimension = 38, @idTalla = 3, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 54, @idTalla = 3, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 48, @idTalla = 3, @idUbicacion = 15

-- Sudadera--
exec Producto.agregarMedida @dimension = 51, @idTalla = 4, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 70, @idTalla = 4, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 60, @idTalla = 4, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 96.95, @idTalla = 4, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 125.72, @idTalla = 4, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 109.84, @idTalla = 4, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 54.31, @idTalla = 4, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 86.66, @idTalla = 5, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 119.71, @idTalla = 5, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 113.23, @idTalla = 5, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 164.23, @idTalla = 5, @idUbicacion = 3

exec Producto.agregarMedida @dimension = 149.98, @idTalla = 6, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 110.11, @idTalla = 6, @idUbicacion = 3
exec Producto.agregarMedida @dimension = 72.40, @idTalla = 6, @idUbicacion = 14
exec Producto.agregarMedida @dimension = 67.49, @idTalla = 6, @idUbicacion = 13

exec Producto.agregarMedida @dimension = 75.35, @idTalla = 7, @idUbicacion = 13
exec Producto.agregarMedida @dimension = 132.32, @idTalla = 7, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 38.67, @idTalla = 7, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 122.09, @idTalla = 7, @idUbicacion = 7

exec Producto.agregarMedida @dimension = 114.95, @idTalla = 8, @idUbicacion = 4
exec Producto.agregarMedida @dimension = 92.80, @idTalla = 8, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 122.02, @idTalla = 8, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 68.70, @idTalla = 8, @idUbicacion = 13

exec Producto.agregarMedida @dimension = 58.27, @idTalla = 9, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 137.58, @idTalla = 9, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 78.26, @idTalla = 9, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 104.14, @idTalla = 9, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 43.88, @idTalla = 10, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 75.65, @idTalla = 10, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 52.73, @idTalla = 10, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 53.52, @idTalla = 10, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 127.03, @idTalla = 11, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 88.17, @idTalla = 11, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 56.67, @idTalla = 11, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 94.47, @idTalla = 11, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 116.27, @idTalla = 12, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 37.90, @idTalla = 12, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 61.46, @idTalla = 12, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 52.98, @idTalla = 12, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 50.93, @idTalla = 13, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 81.96, @idTalla = 13, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 125.49, @idTalla = 13, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 149.72, @idTalla = 13, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 48.25, @idTalla = 14, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 85.96, @idTalla = 14, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 21.03, @idTalla = 14, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 81.91, @idTalla = 14, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 88.74, @idTalla = 15, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 149.22, @idTalla = 15, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 229.49, @idTalla = 15, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 105.17, @idTalla = 15, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 92.57, @idTalla = 16, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 123.65, @idTalla = 16, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 104.41, @idTalla = 16, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 52.94, @idTalla = 16, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 44.01, @idTalla = 17, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 71.58, @idTalla = 17, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 26.20, @idTalla = 17, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 41.47, @idTalla = 18, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 62.64, @idTalla = 18, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 28.10, @idTalla = 18, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 49.87, @idTalla = 19, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 72.60, @idTalla = 19, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 23.34, @idTalla = 19, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 50.89, @idTalla = 20, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 68.95, @idTalla = 20, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 31.90, @idTalla = 20, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 43.11, @idTalla = 21, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 23.12, @idTalla = 21, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 138.69, @idTalla = 21, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 51.41, @idTalla = 21, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 61.46, @idTalla = 22, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 78.81, @idTalla = 22, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 98.36, @idTalla = 22, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 112.11, @idTalla = 22, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 75.81, @idTalla = 23, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 120.57, @idTalla = 23, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 63.56, @idTalla = 23, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 140.84, @idTalla = 23, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 104.87, @idTalla = 24, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 56.16, @idTalla = 24, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 78.73, @idTalla = 24, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 57.63, @idTalla = 24, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 277.20, @idTalla = 25, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 90.80, @idTalla = 25, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 65.80, @idTalla = 25, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 38.28, @idTalla = 25, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 54.99, @idTalla = 26, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 157.75, @idTalla = 26, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 138.15, @idTalla = 26, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 130.27, @idTalla = 26, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 27.67, @idTalla = 27, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 71.19, @idTalla = 27, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 210.54, @idTalla = 27, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 103.26, @idTalla = 27, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 57.24, @idTalla = 28, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 261.21, @idTalla = 28, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 288.20, @idTalla = 28, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 60.17, @idTalla = 28, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 54.69, @idTalla = 29, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 55.87, @idTalla = 29, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 21.82, @idTalla = 29, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 41.83, @idTalla = 30, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 96.66, @idTalla = 30, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 32.96, @idTalla = 30, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 42.47, @idTalla = 31, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 83.96, @idTalla = 31, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 21.36, @idTalla = 31, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 52.27, @idTalla = 32, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 57.71, @idTalla = 32, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 24.43, @idTalla = 32, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 40.30, @idTalla = 33, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 100.57, @idTalla = 33, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 72.37, @idTalla = 33, @idUbicacion = 13
exec Producto.agregarMedida @dimension = 79.92, @idTalla = 33, @idUbicacion = 14

exec Producto.agregarMedida @dimension = 74.72, @idTalla = 34, @idUbicacion = 14
exec Producto.agregarMedida @dimension = 38.78, @idTalla = 34, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 178.87, @idTalla = 34, @idUbicacion = 4
exec Producto.agregarMedida @dimension = 72.43, @idTalla = 34, @idUbicacion = 13

exec Producto.agregarMedida @dimension = 51.22, @idTalla = 35, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 47.74, @idTalla = 35, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 55.88, @idTalla = 35, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 81.47, @idTalla = 35, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 87.09, @idTalla = 36, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 69.53, @idTalla = 36, @idUbicacion = 14
exec Producto.agregarMedida @dimension = 89.43, @idTalla = 36, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 64.97, @idTalla = 36, @idUbicacion = 13

exec Producto.agregarMedida @dimension = 266.38, @idTalla = 37, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 98.70, @idTalla = 37, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 21.05, @idTalla = 37, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 44.76, @idTalla = 37, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 127.12, @idTalla = 38, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 191.01, @idTalla = 38, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 141.76, @idTalla = 38, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 116.13, @idTalla = 38, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 50.60, @idTalla = 39, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 78.99, @idTalla = 39, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 138.62, @idTalla = 39, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 63.72, @idTalla = 39, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 52.79, @idTalla = 40, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 49.33, @idTalla = 40, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 74.54, @idTalla = 40, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 97.83, @idTalla = 40, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 56.68, @idTalla = 41, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 81.40, @idTalla = 41, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 128.11, @idTalla = 41, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 55.83, @idTalla = 41, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 138.76, @idTalla = 42, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 87.69, @idTalla = 42, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 102.78, @idTalla = 42, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 114.62, @idTalla = 42, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 51.13, @idTalla = 43, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 136.82, @idTalla = 43, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 110.52, @idTalla = 43, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 86.51, @idTalla = 43, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 85.03, @idTalla = 44, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 51.14, @idTalla = 44, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 115.30, @idTalla = 44, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 114.75, @idTalla = 44, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 151.23, @idTalla = 45, @idUbicacion = 3
exec Producto.agregarMedida @dimension = 67.11, @idTalla = 45, @idUbicacion = 14
exec Producto.agregarMedida @dimension = 64.11, @idTalla = 45, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 179.33, @idTalla = 45, @idUbicacion = 4

exec Producto.agregarMedida @dimension = 55.11, @idTalla = 46, @idUbicacion = 11
exec Producto.agregarMedida @dimension = 72.65, @idTalla = 46, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 95.05, @idTalla = 46, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 72.13, @idTalla = 46, @idUbicacion = 13

exec Producto.agregarMedida @dimension = 165.74, @idTalla = 47, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 68.01, @idTalla = 47, @idUbicacion = 13
exec Producto.agregarMedida @dimension = 79.80, @idTalla = 47, @idUbicacion = 13
exec Producto.agregarMedida @dimension = 168.23, @idTalla = 47, @idUbicacion = 3

exec Producto.agregarMedida @dimension = 46.63, @idTalla = 48, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 52.33, @idTalla = 48, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 69.63, @idTalla = 48, @idUbicacion = 13
exec Producto.agregarMedida @dimension = 112.82, @idTalla = 48, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 145.39, @idTalla = 49, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 49.88, @idTalla = 49, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 91.50, @idTalla = 49, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 188.13, @idTalla = 49, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 86.91, @idTalla = 50, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 54.96, @idTalla = 50, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 63.00, @idTalla = 50, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 102.45, @idTalla = 50, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 94.05, @idTalla = 51, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 139.84, @idTalla = 51, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 75.44, @idTalla = 51, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 78.02, @idTalla = 51, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 90.17, @idTalla = 52, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 50.93, @idTalla = 52, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 219.10, @idTalla = 52, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 41.25, @idTalla = 52, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 55.64, @idTalla = 53, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 138.41, @idTalla = 53, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 167.76, @idTalla = 53, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 47.52, @idTalla = 53, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 79.69, @idTalla = 54, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 25.98, @idTalla = 54, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 122.59, @idTalla = 54, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 59.65, @idTalla = 54, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 114.74, @idTalla = 55, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 85.42, @idTalla = 55, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 101.39, @idTalla = 55, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 82.13, @idTalla = 55, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 86.17, @idTalla = 56, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 180.57, @idTalla = 56, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 122.01, @idTalla = 56, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 297.87, @idTalla = 56, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 75.50, @idTalla = 57, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 143.50, @idTalla = 57, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 121.00, @idTalla = 57, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 106.14, @idTalla = 57, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 56.51, @idTalla = 58, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 133.90, @idTalla = 58, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 149.63, @idTalla = 58, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 56.89, @idTalla = 58, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 95.65, @idTalla = 59, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 81.19, @idTalla = 59, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 82.30, @idTalla = 59, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 68.07, @idTalla = 59, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 58.20, @idTalla = 60, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 72.92, @idTalla = 60, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 71.35, @idTalla = 60, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 86.29, @idTalla = 60, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 99.12, @idTalla = 61, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 91.17, @idTalla = 61, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 92.08, @idTalla = 61, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 87.22, @idTalla = 61, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 43.20, @idTalla = 62, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 46.19, @idTalla = 62, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 50.47, @idTalla = 62, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 42.74, @idTalla = 62, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 50.38, @idTalla = 63, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 93.93, @idTalla = 63, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 50.76, @idTalla = 63, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 69.75, @idTalla = 63, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 87.74, @idTalla = 64, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 47.11, @idTalla = 64, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 98.75, @idTalla = 64, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 44.79, @idTalla = 64, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 128.15, @idTalla = 65, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 60.94, @idTalla = 65, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 95.00, @idTalla = 65, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 38.94, @idTalla = 65, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 76.36, @idTalla = 66, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 90.79, @idTalla = 66, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 142.78, @idTalla = 66, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 55.26, @idTalla = 66, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 48.47, @idTalla = 67, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 157.40, @idTalla = 67, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 127.74, @idTalla = 67, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 149.16, @idTalla = 67, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 76.30, @idTalla = 68, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 135.91, @idTalla = 68, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 50.73, @idTalla = 68, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 139.55, @idTalla = 68, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 54.09, @idTalla = 69, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 66.88, @idTalla = 69, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 37.22, @idTalla = 69, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 40.21, @idTalla = 70, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 60.08, @idTalla = 70, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 35.24, @idTalla = 70, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 57.53, @idTalla = 71, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 92.86, @idTalla = 71, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 29.40, @idTalla = 71, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 56.84, @idTalla = 72, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 99.12, @idTalla = 72, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 26.59, @idTalla = 72, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 51.78, @idTalla = 73, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 103.77, @idTalla = 73, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 91.99, @idTalla = 73, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 176.02, @idTalla = 73, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 72.10, @idTalla = 74, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 90.20, @idTalla = 74, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 51.46, @idTalla = 74, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 165.51, @idTalla = 74, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 72.78, @idTalla = 75, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 74.95, @idTalla = 75, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 137.93, @idTalla = 75, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 13.54, @idTalla = 75, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 40.75, @idTalla = 76, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 71.10, @idTalla = 76, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 128.39, @idTalla = 76, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 84.34, @idTalla = 76, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 50.17, @idTalla = 77, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 82.87, @idTalla = 77, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 18.26, @idTalla = 77, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 138.98, @idTalla = 77, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 59.93, @idTalla = 78, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 170.78, @idTalla = 78, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 61.73, @idTalla = 78, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 243.05, @idTalla = 78, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 56.85, @idTalla = 79, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 149.80, @idTalla = 79, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 127.06, @idTalla = 79, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 180.67, @idTalla = 79, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 95.69, @idTalla = 80, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 93.78, @idTalla = 80, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 220.16, @idTalla = 80, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 47.12, @idTalla = 80, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 90.31, @idTalla = 81, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 133.86, @idTalla = 81, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 211.69, @idTalla = 81, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 94.83, @idTalla = 81, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 142.97, @idTalla = 82, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 62.92, @idTalla = 82, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 115.27, @idTalla = 82, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 166.16, @idTalla = 82, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 160.50, @idTalla = 83, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 53.24, @idTalla = 83, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 51.96, @idTalla = 83, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 128.61, @idTalla = 83, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 55.89, @idTalla = 84, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 53.65, @idTalla = 84, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 234.51, @idTalla = 84, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 48.92, @idTalla = 84, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 44.49, @idTalla = 85, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 61.60, @idTalla = 85, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 32.36, @idTalla = 85, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 59.00, @idTalla = 86, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 44.97, @idTalla = 86, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 35.17, @idTalla = 86, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 43.24, @idTalla = 87, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 71.55, @idTalla = 87, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 28.98, @idTalla = 87, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 41.67, @idTalla = 88, @idUbicacion = 18
exec Producto.agregarMedida @dimension = 90.28, @idTalla = 88, @idUbicacion = 19
exec Producto.agregarMedida @dimension = 33.96, @idTalla = 88, @idUbicacion = 20

exec Producto.agregarMedida @dimension = 87.83, @idTalla = 89, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 70.33, @idTalla = 89, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 78.82, @idTalla = 89, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 170.37, @idTalla = 89, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 44.33, @idTalla = 90, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 91.94, @idTalla = 90, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 54.77, @idTalla = 90, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 117.20, @idTalla = 90, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 42.49, @idTalla = 91, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 43.78, @idTalla = 91, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 144.94, @idTalla = 91, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 54.27, @idTalla = 91, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 53.88, @idTalla = 92, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 126.86, @idTalla = 92, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 217.83, @idTalla = 92, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 169.61, @idTalla = 92, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 129.41, @idTalla = 93, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 103.00, @idTalla = 93, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 91.92, @idTalla = 93, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 110.14, @idTalla = 93, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 44.84, @idTalla = 94, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 57.73, @idTalla = 94, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 119.02, @idTalla = 94, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 109.32, @idTalla = 94, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 41.53, @idTalla = 95, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 62.87, @idTalla = 95, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 70.78, @idTalla = 95, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 92.33, @idTalla = 95, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 119.96, @idTalla = 96, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 135.29, @idTalla = 96, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 94.25, @idTalla = 96, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 60.61, @idTalla = 96, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 87.87, @idTalla = 97, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 199.12, @idTalla = 97, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 57.52, @idTalla = 97, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 90.00, @idTalla = 97, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 82.74, @idTalla = 98, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 91.55, @idTalla = 98, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 124.30, @idTalla = 98, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 204.10, @idTalla = 98, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 107.89, @idTalla = 99, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 217.33, @idTalla = 99, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 158.83, @idTalla = 99, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 40.16, @idTalla = 99, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 52.28, @idTalla = 100, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 112.61, @idTalla = 100, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 45.88, @idTalla = 100, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 43.50, @idTalla = 100, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 119.71, @idTalla = 101, @idUbicacion = 4
exec Producto.agregarMedida @dimension = 66.63, @idTalla = 101, @idUbicacion = 14
exec Producto.agregarMedida @dimension = 124.62, @idTalla = 101, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 32.07, @idTalla = 101, @idUbicacion = 11

exec Producto.agregarMedida @dimension = 61.25, @idTalla = 102, @idUbicacion = 13
exec Producto.agregarMedida @dimension = 169.56, @idTalla = 102, @idUbicacion = 4
exec Producto.agregarMedida @dimension = 171.52, @idTalla = 102, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 137.21, @idTalla = 102, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 76.76, @idTalla = 103, @idUbicacion = 14
exec Producto.agregarMedida @dimension = 136.83, @idTalla = 103, @idUbicacion = 4
exec Producto.agregarMedida @dimension = 54.87, @idTalla = 103, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 188.26, @idTalla = 103, @idUbicacion = 4

exec Producto.agregarMedida @dimension = 123.40, @idTalla = 104, @idUbicacion = 3
exec Producto.agregarMedida @dimension = 113.00, @idTalla = 104, @idUbicacion = 7
exec Producto.agregarMedida @dimension = 137.22, @idTalla = 104, @idUbicacion = 3
exec Producto.agregarMedida @dimension = 153.77, @idTalla = 104, @idUbicacion = 4

exec Producto.agregarMedida @dimension = 65.00, @idTalla = 105, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 60.22, @idTalla = 105, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 74.90, @idTalla = 105, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 83.65, @idTalla = 105, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 128.46, @idTalla = 106, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 73.06, @idTalla = 106, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 80.59, @idTalla = 106, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 70.14, @idTalla = 106, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 86.59, @idTalla = 107, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 46.98, @idTalla = 107, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 62.50, @idTalla = 107, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 140.44, @idTalla = 107, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 237.94, @idTalla = 108, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 96.33, @idTalla = 108, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 65.76, @idTalla = 108, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 226.82, @idTalla = 108, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 91.58, @idTalla = 109, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 47.21, @idTalla = 109, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 64.72, @idTalla = 109, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 149.64, @idTalla = 109, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 167.56, @idTalla = 110, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 55.38, @idTalla = 110, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 56.57, @idTalla = 110, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 95.31, @idTalla = 110, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 148.99, @idTalla = 111, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 104.61, @idTalla = 111, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 68.77, @idTalla = 111, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 108.86, @idTalla = 111, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 172.15, @idTalla = 112, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 83.50, @idTalla = 112, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 84.33, @idTalla = 112, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 102.31, @idTalla = 112, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 59.44, @idTalla = 113, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 59.30, @idTalla = 113, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 42.41, @idTalla = 113, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 55.88, @idTalla = 113, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 231.96, @idTalla = 114, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 94.54, @idTalla = 114, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 47.12, @idTalla = 114, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 80.88, @idTalla = 114, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 120.06, @idTalla = 115, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 95.46, @idTalla = 115, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 75.55, @idTalla = 115, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 138.84, @idTalla = 115, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 71.70, @idTalla = 116, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 224.56, @idTalla = 116, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 129.31, @idTalla = 116, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 118.94, @idTalla = 116, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 41.83, @idTalla = 117, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 125.96, @idTalla = 117, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 149.10, @idTalla = 117, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 75.14, @idTalla = 117, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 40.85, @idTalla = 118, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 55.02, @idTalla = 118, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 42.31, @idTalla = 118, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 68.42, @idTalla = 118, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 109.84, @idTalla = 119, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 45.22, @idTalla = 119, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 86.97, @idTalla = 119, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 45.41, @idTalla = 119, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 97.28, @idTalla = 120, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 183.23, @idTalla = 120, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 280.55, @idTalla = 120, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 65.85, @idTalla = 120, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 48.09, @idTalla = 121, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 54.41, @idTalla = 121, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 50.03, @idTalla = 121, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 121.04, @idTalla = 121, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 96.33, @idTalla = 122, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 65.12, @idTalla = 122, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 226.91, @idTalla = 122, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 114.19, @idTalla = 122, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 128.14, @idTalla = 123, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 60.51, @idTalla = 123, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 87.70, @idTalla = 123, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 46.57, @idTalla = 123, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 157.16, @idTalla = 124, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 104.49, @idTalla = 124, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 135.93, @idTalla = 124, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 76.70, @idTalla = 124, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 97.01, @idTalla = 125, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 89.06, @idTalla = 125, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 70.04, @idTalla = 125, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 77.12, @idTalla = 125, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 93.46, @idTalla = 126, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 111.58, @idTalla = 126, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 293.50, @idTalla = 126, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 75.03, @idTalla = 126, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 44.50, @idTalla = 127, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 51.19, @idTalla = 127, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 73.93, @idTalla = 127, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 226.60, @idTalla = 127, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 77.89, @idTalla = 128, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 50.31, @idTalla = 128, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 255.31, @idTalla = 128, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 92.67, @idTalla = 128, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 115.68, @idTalla = 129, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 74.96, @idTalla = 129, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 50.10, @idTalla = 129, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 76.46, @idTalla = 129, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 141.66, @idTalla = 130, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 116.40, @idTalla = 130, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 89.96, @idTalla = 130, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 67.30, @idTalla = 130, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 75.03, @idTalla = 131, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 123.51, @idTalla = 131, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 70.03, @idTalla = 131, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 97.00, @idTalla = 131, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 51.33, @idTalla = 132, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 56.92, @idTalla = 132, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 249.97, @idTalla = 132, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 94.04, @idTalla = 132, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 100.55, @idTalla = 133, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 203.71, @idTalla = 133, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 203.67, @idTalla = 133, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 253.62, @idTalla = 133, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 60.31, @idTalla = 134, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 90.95, @idTalla = 134, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 105.05, @idTalla = 134, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 66.80, @idTalla = 134, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 68.93, @idTalla = 135, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 195.21, @idTalla = 135, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 96.13, @idTalla = 135, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 73.54, @idTalla = 135, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 98.16, @idTalla = 136, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 64.77, @idTalla = 136, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 63.63, @idTalla = 136, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 131.41, @idTalla = 136, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 113.83, @idTalla = 137, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 98.69, @idTalla = 137, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 104.25, @idTalla = 137, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 84.87, @idTalla = 137, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 141.66, @idTalla = 138, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 174.16, @idTalla = 138, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 74.04, @idTalla = 138, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 186.43, @idTalla = 138, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 146.26, @idTalla = 139, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 50.62, @idTalla = 139, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 57.80, @idTalla = 139, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 221.07, @idTalla = 139, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 122.63, @idTalla = 140, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 58.60, @idTalla = 140, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 42.27, @idTalla = 140, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 148.46, @idTalla = 140, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 92.20, @idTalla = 141, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 266.61, @idTalla = 141, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 72.86, @idTalla = 141, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 80.20, @idTalla = 141, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 72.91, @idTalla = 142, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 44.63, @idTalla = 142, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 94.04, @idTalla = 142, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 77.84, @idTalla = 142, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 112.86, @idTalla = 143, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 59.91, @idTalla = 143, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 276.86, @idTalla = 143, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 97.84, @idTalla = 143, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 100.14, @idTalla = 144, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 79.50, @idTalla = 144, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 98.07, @idTalla = 144, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 95.89, @idTalla = 144, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 176.66, @idTalla = 145, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 170.69, @idTalla = 145, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 147.69, @idTalla = 145, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 54.67, @idTalla = 145, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 162.79, @idTalla = 146, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 193.98, @idTalla = 146, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 69.12, @idTalla = 146, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 106.43, @idTalla = 146, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 59.32, @idTalla = 147, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 53.88, @idTalla = 147, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 72.41, @idTalla = 147, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 66.27, @idTalla = 147, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 57.13, @idTalla = 148, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 116.80, @idTalla = 148, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 109.03, @idTalla = 148, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 229.37, @idTalla = 148, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 64.26, @idTalla = 149, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 53.07, @idTalla = 149, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 67.73, @idTalla = 149, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 282.18, @idTalla = 149, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 54.09, @idTalla = 150, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 52.41, @idTalla = 150, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 26.45, @idTalla = 150, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 122.90, @idTalla = 150, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 231.56, @idTalla = 151, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 93.76, @idTalla = 151, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 125.15, @idTalla = 151, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 246.87, @idTalla = 151, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 146.30, @idTalla = 152, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 98.43, @idTalla = 152, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 78.52, @idTalla = 152, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 49.57, @idTalla = 152, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 53.44, @idTalla = 153, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 75.57, @idTalla = 153, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 72.27, @idTalla = 153, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 72.04, @idTalla = 153, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 89.95, @idTalla = 154, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 65.40, @idTalla = 154, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 142.42, @idTalla = 154, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 131.51, @idTalla = 154, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 50.23, @idTalla = 155, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 81.96, @idTalla = 155, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 128.38, @idTalla = 155, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 95.57, @idTalla = 155, @idUbicacion = 5

exec Producto.agregarMedida @dimension = 55.15, @idTalla = 156, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 151.46, @idTalla = 156, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 68.18, @idTalla = 156, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 61.59, @idTalla = 156, @idUbicacion = 17

exec Producto.agregarMedida @dimension = 119.50, @idTalla = 157, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 113.09, @idTalla = 157, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 78.97, @idTalla = 157, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 123.29, @idTalla = 157, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 77.77, @idTalla = 158, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 229.93, @idTalla = 158, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 47.25, @idTalla = 158, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 71.74, @idTalla = 158, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 93.72, @idTalla = 159, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 64.56, @idTalla = 159, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 52.15, @idTalla = 159, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 47.98, @idTalla = 159, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 47.76, @idTalla = 160, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 101.93, @idTalla = 160, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 84.52, @idTalla = 160, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 69.38, @idTalla = 160, @idUbicacion = 10

exec Producto.agregarMedida @dimension = 81.58, @idTalla = 161, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 60.35, @idTalla = 161, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 53.74, @idTalla = 161, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 236.49, @idTalla = 161, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 84.54, @idTalla = 162, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 99.12, @idTalla = 162, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 80.96, @idTalla = 162, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 148.02, @idTalla = 162, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 80.37, @idTalla = 163, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 99.56, @idTalla = 163, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 61.75, @idTalla = 163, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 128.59, @idTalla = 163, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 111.14, @idTalla = 164, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 71.96, @idTalla = 164, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 99.16, @idTalla = 164, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 64.98, @idTalla = 164, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 143.78, @idTalla = 165, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 123.04, @idTalla = 165, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 74.28, @idTalla = 165, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 68.43, @idTalla = 165, @idUbicacion = 16

exec Producto.agregarMedida @dimension = 205.28, @idTalla = 166, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 66.04, @idTalla = 166, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 139.24, @idTalla = 166, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 285.52, @idTalla = 166, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 107.69, @idTalla = 167, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 41.79, @idTalla = 167, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 72.50, @idTalla = 167, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 86.43, @idTalla = 167, @idUbicacion = 15

exec Producto.agregarMedida @dimension = 238.83, @idTalla = 168, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 81.75, @idTalla = 168, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 84.03, @idTalla = 168, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 45.90, @idTalla = 168, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 41.73, @idTalla = 169, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 131.02, @idTalla = 169, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 83.93, @idTalla = 169, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 93.75, @idTalla = 169, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 91.80, @idTalla = 170, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 86.92, @idTalla = 170, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 59.62, @idTalla = 170, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 105.85, @idTalla = 170, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 133.60, @idTalla = 171, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 109.75, @idTalla = 171, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 126.65, @idTalla = 171, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 90.01, @idTalla = 171, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 144.61, @idTalla = 172, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 227.77, @idTalla = 172, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 134.94, @idTalla = 172, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 59.73, @idTalla = 172, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 129.97, @idTalla = 173, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 145.52, @idTalla = 173, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 103.89, @idTalla = 173, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 273.58, @idTalla = 173, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 48.91, @idTalla = 174, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 73.78, @idTalla = 174, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 74.03, @idTalla = 174, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 54.67, @idTalla = 174, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 66.06, @idTalla = 175, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 99.94, @idTalla = 175, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 176.77, @idTalla = 175, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 52.60, @idTalla = 175, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 135.07, @idTalla = 176, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 60.80, @idTalla = 176, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 83.89, @idTalla = 176, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 66.88, @idTalla = 176, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 235.44, @idTalla = 177, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 58.79, @idTalla = 177, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 53.54, @idTalla = 177, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 74.86, @idTalla = 177, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 89.81, @idTalla = 178, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 140.43, @idTalla = 178, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 59.92, @idTalla = 178, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 58.54, @idTalla = 178, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 95.02, @idTalla = 179, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 87.36, @idTalla = 179, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 65.20, @idTalla = 179, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 46.07, @idTalla = 179, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 86.51, @idTalla = 180, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 203.56, @idTalla = 180, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 47.78, @idTalla = 180, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 55.91, @idTalla = 180, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 109.64, @idTalla = 181, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 224.99, @idTalla = 181, @idUbicacion = 16
exec Producto.agregarMedida @dimension = 65.49, @idTalla = 181, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 145.30, @idTalla = 181, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 69.02, @idTalla = 182, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 96.59, @idTalla = 182, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 59.31, @idTalla = 182, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 65.51, @idTalla = 182, @idUbicacion = 6

exec Producto.agregarMedida @dimension = 57.72, @idTalla = 183, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 109.87, @idTalla = 183, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 106.63, @idTalla = 183, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 106.09, @idTalla = 183, @idUbicacion = 2

exec Producto.agregarMedida @dimension = 91.32, @idTalla = 184, @idUbicacion = 9
exec Producto.agregarMedida @dimension = 120.61, @idTalla = 184, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 116.26, @idTalla = 184, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 289.49, @idTalla = 184, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 58.53, @idTalla = 185, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 73.81, @idTalla = 185, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 123.28, @idTalla = 185, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 118.17, @idTalla = 185, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 78.07, @idTalla = 186, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 57.66, @idTalla = 186, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 112.93, @idTalla = 186, @idUbicacion = 15
exec Producto.agregarMedida @dimension = 179.46, @idTalla = 186, @idUbicacion = 1

exec Producto.agregarMedida @dimension = 71.36, @idTalla = 187, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 91.33, @idTalla = 187, @idUbicacion = 5
exec Producto.agregarMedida @dimension = 57.48, @idTalla = 187, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 49.78, @idTalla = 187, @idUbicacion = 12

exec Producto.agregarMedida @dimension = 57.63, @idTalla = 188, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 116.92, @idTalla = 188, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 56.67, @idTalla = 188, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 140.63, @idTalla = 188, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 147.61, @idTalla = 189, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 62.63, @idTalla = 189, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 62.03, @idTalla = 189, @idUbicacion = 10
exec Producto.agregarMedida @dimension = 66.17, @idTalla = 189, @idUbicacion = 9

exec Producto.agregarMedida @dimension = 64.50, @idTalla = 190, @idUbicacion = 17
exec Producto.agregarMedida @dimension = 47.02, @idTalla = 190, @idUbicacion = 12
exec Producto.agregarMedida @dimension = 47.33, @idTalla = 190, @idUbicacion = 6
exec Producto.agregarMedida @dimension = 86.13, @idTalla = 190, @idUbicacion = 8

exec Producto.agregarMedida @dimension = 87.19, @idTalla = 191, @idUbicacion = 8
exec Producto.agregarMedida @dimension = 110.41, @idTalla = 191, @idUbicacion = 2
exec Producto.agregarMedida @dimension = 111.75, @idTalla = 191, @idUbicacion = 1
exec Producto.agregarMedida @dimension = 76.32, @idTalla = 191, @idUbicacion = 17

EXEC agregarColor 'Azul'
EXEC agregarColor 'Amarillo'
EXEC agregarColor 'Ámbar'
EXEC agregarColor 'Añil'
EXEC agregarColor 'Beige'
EXEC agregarColor 'Blanco'
EXEC agregarColor 'Café'
EXEC agregarColor 'Celeste'
EXEC agregarColor 'Caqui'
EXEC agregarColor 'Ámbar'
EXEC agregarColor 'Carmesí'
EXEC agregarColor 'Castaño'
EXEC agregarColor 'Cobre'
EXEC agregarColor 'Colores'
EXEC agregarColor 'Fucsia'
EXEC agregarColor 'Gris'
EXEC agregarColor 'Hueso'
EXEC agregarColor 'Magenta'
EXEC agregarColor 'Marrón'
EXEC agregarColor 'Negro'
EXEC agregarColor 'Naranja'
EXEC agregarColor 'Ocre'
EXEC agregarColor 'Morado'
EXEC agregarColor 'Plata'
EXEC agregarColor 'Púrpura'
EXEC agregarColor 'Rojo'
EXEC agregarColor 'Rosa'
EXEC agregarColor 'Salmón'
EXEC agregarColor 'Verde'
EXEC agregarColor 'Verde Lima'
EXEC agregarColor 'Verde Esmeralda'
EXEC agregarColor 'Violeta'
EXEC agregarColor 'Vino'
EXEC agregarColor 'Champán'
EXEC agregarColor 'Blanco Márfil'
EXEC agregarColor 'Azul Claro'
EXEC agregarColor 'Azul Eléctrico'
EXEC agregarColor 'Bermellón'
EXEC agregarColor 'Cereza'
EXEC agregarColor 'Gris Perla'
EXEC agregarColor 'Lila'
EXEC agregarColor 'Rojo Carmín'
EXEC agregarColor 'Turquesa'
EXEC agregarColor 'Oliva'
EXEC agregarColor 'Verde Esmeralda'
EXEC agregarColor 'Pistacho'
EXEC agregarColor 'Verde Musgo'
EXEC agregarColor 'Ciruela'

EXEC Produccion.agregartipoUnidadMedidas 'YDS','Yardas'
EXEC Produccion.agregartipoUnidadMedidas 'GAL','Galones'
EXEC Produccion.agregartipoUnidadMedidas 'LTR','Litros'
EXEC Produccion.agregartipoUnidadMedidas 'UDS','Unidades'

EXEC Bodega.agregarTipoMateriaPrima 'Tela','YDS'
EXEC Bodega.agregarTipoMateriaPrima 'Hilo', 'YDS'
EXEC Bodega.agregarTipoMateriaPrima 'Cordones', 'YDS'
EXEC Bodega.agregarTipoMateriaPrima 'Viñetas', 'UDS'
EXEC Bodega.agregarTipoMateriaPrima 'Tintas', 'LTR'

EXEC Bodega.agregarEstante 'A'
EXEC Bodega.agregarEstante 'B'
EXEC Bodega.agregarEstante 'C'
EXEC Bodega.agregarEstante 'D'
EXEC Bodega.agregarEstante 'E'
EXEC Bodega.agregarEstante 'F'
EXEC Bodega.agregarEstante 'G'
EXEC Bodega.agregarEstante 'H'

EXEC Bodega.agregarNivel 1
EXEC Bodega.agregarNivel 2
EXEC Bodega.agregarNivel 3
EXEC Bodega.agregarNivel 4
EXEC Bodega.agregarNivel 5
EXEC Bodega.agregarNivel 6
EXEC Bodega.agregarNivel 7
EXEC Bodega.agregarNivel 8

EXEC Bodega.agregarColumna 1
EXEC Bodega.agregarColumna 2
EXEC Bodega.agregarColumna 3
EXEC Bodega.agregarColumna 4
EXEC Bodega.agregarColumna 5
EXEC Bodega.agregarColumna 6
EXEC Bodega.agregarColumna 7
EXEC Bodega.agregarColumna 8
EXEC Bodega.agregarColumna 9

EXEC Bodega.agregarCompartimiento A11,0
EXEC Bodega.agregarCompartimiento A12,0
EXEC Bodega.agregarCompartimiento A13,0
EXEC Bodega.agregarCompartimiento A14,0
EXEC Bodega.agregarCompartimiento A15,0
EXEC Bodega.agregarCompartimiento A16,0
EXEC Bodega.agregarCompartimiento A17,0
EXEC Bodega.agregarCompartimiento A18,0
EXEC Bodega.agregarCompartimiento A19,0
EXEC Bodega.agregarCompartimiento A21,0
EXEC Bodega.agregarCompartimiento A22,0
EXEC Bodega.agregarCompartimiento A23,0
EXEC Bodega.agregarCompartimiento A24,0
EXEC Bodega.agregarCompartimiento A25,0
EXEC Bodega.agregarCompartimiento A26,0
EXEC Bodega.agregarCompartimiento A27,0
EXEC Bodega.agregarCompartimiento A28,0
EXEC Bodega.agregarCompartimiento A29,0
EXEC Bodega.agregarCompartimiento A31,0
EXEC Bodega.agregarCompartimiento A32,0
EXEC Bodega.agregarCompartimiento A33,0
EXEC Bodega.agregarCompartimiento A34,0
EXEC Bodega.agregarCompartimiento A35,0
EXEC Bodega.agregarCompartimiento A36,0
EXEC Bodega.agregarCompartimiento A37,0
EXEC Bodega.agregarCompartimiento A38,0
EXEC Bodega.agregarCompartimiento A39,0
EXEC Bodega.agregarCompartimiento A41,0
EXEC Bodega.agregarCompartimiento A42,0
EXEC Bodega.agregarCompartimiento A43,0
EXEC Bodega.agregarCompartimiento A44,0
EXEC Bodega.agregarCompartimiento A45,0
EXEC Bodega.agregarCompartimiento A46,0
EXEC Bodega.agregarCompartimiento A47,0
EXEC Bodega.agregarCompartimiento A48,0
EXEC Bodega.agregarCompartimiento A49,0
EXEC Bodega.agregarCompartimiento A51,0
EXEC Bodega.agregarCompartimiento A52,0
EXEC Bodega.agregarCompartimiento A53,0
EXEC Bodega.agregarCompartimiento A54,0
EXEC Bodega.agregarCompartimiento A55,0
EXEC Bodega.agregarCompartimiento A56,0
EXEC Bodega.agregarCompartimiento A57,0
EXEC Bodega.agregarCompartimiento A58,0
EXEC Bodega.agregarCompartimiento A59,0
EXEC Bodega.agregarCompartimiento A61,0
EXEC Bodega.agregarCompartimiento A62,0
EXEC Bodega.agregarCompartimiento A63,0
EXEC Bodega.agregarCompartimiento A64,0
EXEC Bodega.agregarCompartimiento A65,0
EXEC Bodega.agregarCompartimiento A66,0
EXEC Bodega.agregarCompartimiento A67,0
EXEC Bodega.agregarCompartimiento A68,0
EXEC Bodega.agregarCompartimiento A69,0
EXEC Bodega.agregarCompartimiento A71,0
EXEC Bodega.agregarCompartimiento A72,0
EXEC Bodega.agregarCompartimiento A73,0
EXEC Bodega.agregarCompartimiento A74,0
EXEC Bodega.agregarCompartimiento A75,0
EXEC Bodega.agregarCompartimiento A76,0
EXEC Bodega.agregarCompartimiento A77,0
EXEC Bodega.agregarCompartimiento A78,0
EXEC Bodega.agregarCompartimiento A79,0
EXEC Bodega.agregarCompartimiento A81,0
EXEC Bodega.agregarCompartimiento A82,0
EXEC Bodega.agregarCompartimiento A83,0
EXEC Bodega.agregarCompartimiento A84,0
EXEC Bodega.agregarCompartimiento A85,0
EXEC Bodega.agregarCompartimiento A86,0
EXEC Bodega.agregarCompartimiento A87,0
EXEC Bodega.agregarCompartimiento A88,0
EXEC Bodega.agregarCompartimiento A89,0
EXEC Bodega.agregarCompartimiento B11,0
EXEC Bodega.agregarCompartimiento B12,0
EXEC Bodega.agregarCompartimiento B13,0
EXEC Bodega.agregarCompartimiento B14,0
EXEC Bodega.agregarCompartimiento B15,0
EXEC Bodega.agregarCompartimiento B16,0
EXEC Bodega.agregarCompartimiento B17,0
EXEC Bodega.agregarCompartimiento B18,0
EXEC Bodega.agregarCompartimiento B19,0
EXEC Bodega.agregarCompartimiento B21,0
EXEC Bodega.agregarCompartimiento B22,0
EXEC Bodega.agregarCompartimiento B23,0
EXEC Bodega.agregarCompartimiento B24,0
EXEC Bodega.agregarCompartimiento B25,0
EXEC Bodega.agregarCompartimiento B26,0
EXEC Bodega.agregarCompartimiento B27,0
EXEC Bodega.agregarCompartimiento B28,0
EXEC Bodega.agregarCompartimiento B29,0
EXEC Bodega.agregarCompartimiento B31,0
EXEC Bodega.agregarCompartimiento B32,0
EXEC Bodega.agregarCompartimiento B33,0
EXEC Bodega.agregarCompartimiento B34,0
EXEC Bodega.agregarCompartimiento B35,0
EXEC Bodega.agregarCompartimiento B36,0
EXEC Bodega.agregarCompartimiento B37,0
EXEC Bodega.agregarCompartimiento B38,0
EXEC Bodega.agregarCompartimiento B39,0
EXEC Bodega.agregarCompartimiento B41,0
EXEC Bodega.agregarCompartimiento B42,0
EXEC Bodega.agregarCompartimiento B43,0
EXEC Bodega.agregarCompartimiento B44,0
EXEC Bodega.agregarCompartimiento B45,0
EXEC Bodega.agregarCompartimiento B46,0
EXEC Bodega.agregarCompartimiento B47,0
EXEC Bodega.agregarCompartimiento B48,0
EXEC Bodega.agregarCompartimiento B49,0
EXEC Bodega.agregarCompartimiento B51,0
EXEC Bodega.agregarCompartimiento B52,0
EXEC Bodega.agregarCompartimiento B53,0
EXEC Bodega.agregarCompartimiento B54,0
EXEC Bodega.agregarCompartimiento B55,0
EXEC Bodega.agregarCompartimiento B56,0
EXEC Bodega.agregarCompartimiento B57,0
EXEC Bodega.agregarCompartimiento B58,0
EXEC Bodega.agregarCompartimiento B59,0
EXEC Bodega.agregarCompartimiento B61,0
EXEC Bodega.agregarCompartimiento B62,0
EXEC Bodega.agregarCompartimiento B63,0
EXEC Bodega.agregarCompartimiento B64,0
EXEC Bodega.agregarCompartimiento B65,0
EXEC Bodega.agregarCompartimiento B66,0
EXEC Bodega.agregarCompartimiento B67,0
EXEC Bodega.agregarCompartimiento B68,0
EXEC Bodega.agregarCompartimiento B69,0
EXEC Bodega.agregarCompartimiento B71,0
EXEC Bodega.agregarCompartimiento B72,0
EXEC Bodega.agregarCompartimiento B73,0
EXEC Bodega.agregarCompartimiento B74,0
EXEC Bodega.agregarCompartimiento B75,0
EXEC Bodega.agregarCompartimiento B76,0
EXEC Bodega.agregarCompartimiento B77,0
EXEC Bodega.agregarCompartimiento B78,0
EXEC Bodega.agregarCompartimiento B79,0
EXEC Bodega.agregarCompartimiento B81,0
EXEC Bodega.agregarCompartimiento B82,0
EXEC Bodega.agregarCompartimiento B83,0
EXEC Bodega.agregarCompartimiento B84,0
EXEC Bodega.agregarCompartimiento B85,0
EXEC Bodega.agregarCompartimiento B86,0
EXEC Bodega.agregarCompartimiento B87,0
EXEC Bodega.agregarCompartimiento B88,0
EXEC Bodega.agregarCompartimiento B89,0
EXEC Bodega.agregarCompartimiento C11,0
EXEC Bodega.agregarCompartimiento C12,0
EXEC Bodega.agregarCompartimiento C13,0
EXEC Bodega.agregarCompartimiento C14,0
EXEC Bodega.agregarCompartimiento C15,0
EXEC Bodega.agregarCompartimiento C16,0
EXEC Bodega.agregarCompartimiento C17,0
EXEC Bodega.agregarCompartimiento C18,0
EXEC Bodega.agregarCompartimiento C19,0
EXEC Bodega.agregarCompartimiento C21,0
EXEC Bodega.agregarCompartimiento C22,0
EXEC Bodega.agregarCompartimiento C23,0
EXEC Bodega.agregarCompartimiento C24,0
EXEC Bodega.agregarCompartimiento C25,0
EXEC Bodega.agregarCompartimiento C26,0
EXEC Bodega.agregarCompartimiento C27,0
EXEC Bodega.agregarCompartimiento C28,0
EXEC Bodega.agregarCompartimiento C29,0
EXEC Bodega.agregarCompartimiento C31,0
EXEC Bodega.agregarCompartimiento C32,0
EXEC Bodega.agregarCompartimiento C33,0
EXEC Bodega.agregarCompartimiento C34,0
EXEC Bodega.agregarCompartimiento C35,0
EXEC Bodega.agregarCompartimiento C36,0
EXEC Bodega.agregarCompartimiento C37,0
EXEC Bodega.agregarCompartimiento C38,0
EXEC Bodega.agregarCompartimiento C39,0
EXEC Bodega.agregarCompartimiento C41,0
EXEC Bodega.agregarCompartimiento C42,0
EXEC Bodega.agregarCompartimiento C43,0
EXEC Bodega.agregarCompartimiento C44,0
EXEC Bodega.agregarCompartimiento C45,0
EXEC Bodega.agregarCompartimiento C46,0
EXEC Bodega.agregarCompartimiento C47,0
EXEC Bodega.agregarCompartimiento C48,0
EXEC Bodega.agregarCompartimiento C49,0
EXEC Bodega.agregarCompartimiento C51,0
EXEC Bodega.agregarCompartimiento C52,0
EXEC Bodega.agregarCompartimiento C53,0
EXEC Bodega.agregarCompartimiento C54,0
EXEC Bodega.agregarCompartimiento C55,0
EXEC Bodega.agregarCompartimiento C56,0
EXEC Bodega.agregarCompartimiento C57,0
EXEC Bodega.agregarCompartimiento C58,0
EXEC Bodega.agregarCompartimiento C59,0
EXEC Bodega.agregarCompartimiento C61,0
EXEC Bodega.agregarCompartimiento C62,0
EXEC Bodega.agregarCompartimiento C63,0
EXEC Bodega.agregarCompartimiento C64,0
EXEC Bodega.agregarCompartimiento C65,0
EXEC Bodega.agregarCompartimiento C66,0
EXEC Bodega.agregarCompartimiento C67,0
EXEC Bodega.agregarCompartimiento C68,0
EXEC Bodega.agregarCompartimiento C69,0
EXEC Bodega.agregarCompartimiento C71,0
EXEC Bodega.agregarCompartimiento C72,0
EXEC Bodega.agregarCompartimiento C73,0
EXEC Bodega.agregarCompartimiento C74,0
EXEC Bodega.agregarCompartimiento C75,0
EXEC Bodega.agregarCompartimiento C76,0
EXEC Bodega.agregarCompartimiento C77,0
EXEC Bodega.agregarCompartimiento C78,0
EXEC Bodega.agregarCompartimiento C79,0
EXEC Bodega.agregarCompartimiento C81,0
EXEC Bodega.agregarCompartimiento C82,0
EXEC Bodega.agregarCompartimiento C83,0
EXEC Bodega.agregarCompartimiento C84,0
EXEC Bodega.agregarCompartimiento C85,0
EXEC Bodega.agregarCompartimiento C86,0
EXEC Bodega.agregarCompartimiento C87,0
EXEC Bodega.agregarCompartimiento C88,0
EXEC Bodega.agregarCompartimiento C89,0
EXEC Bodega.agregarCompartimiento D11,0
EXEC Bodega.agregarCompartimiento D12,0
EXEC Bodega.agregarCompartimiento D13,0
EXEC Bodega.agregarCompartimiento D14,0
EXEC Bodega.agregarCompartimiento D15,0
EXEC Bodega.agregarCompartimiento D16,0
EXEC Bodega.agregarCompartimiento D17,0
EXEC Bodega.agregarCompartimiento D18,0
EXEC Bodega.agregarCompartimiento D19,0
EXEC Bodega.agregarCompartimiento D21,0
EXEC Bodega.agregarCompartimiento D22,0
EXEC Bodega.agregarCompartimiento D23,0
EXEC Bodega.agregarCompartimiento D24,0
EXEC Bodega.agregarCompartimiento D25,0
EXEC Bodega.agregarCompartimiento D26,0
EXEC Bodega.agregarCompartimiento D27,0
EXEC Bodega.agregarCompartimiento D28,0
EXEC Bodega.agregarCompartimiento D29,0
EXEC Bodega.agregarCompartimiento D31,0
EXEC Bodega.agregarCompartimiento D32,0
EXEC Bodega.agregarCompartimiento D33,0
EXEC Bodega.agregarCompartimiento D34,0
EXEC Bodega.agregarCompartimiento D35,0
EXEC Bodega.agregarCompartimiento D36,0
EXEC Bodega.agregarCompartimiento D37,0
EXEC Bodega.agregarCompartimiento D38,0
EXEC Bodega.agregarCompartimiento D39,0
EXEC Bodega.agregarCompartimiento D41,0
EXEC Bodega.agregarCompartimiento D42,0
EXEC Bodega.agregarCompartimiento D43,0
EXEC Bodega.agregarCompartimiento D44,0
EXEC Bodega.agregarCompartimiento D45,0
EXEC Bodega.agregarCompartimiento D46,0
EXEC Bodega.agregarCompartimiento D47,0
EXEC Bodega.agregarCompartimiento D48,0
EXEC Bodega.agregarCompartimiento D49,0
EXEC Bodega.agregarCompartimiento D51,0
EXEC Bodega.agregarCompartimiento D52,0
EXEC Bodega.agregarCompartimiento D53,0
EXEC Bodega.agregarCompartimiento D54,0
EXEC Bodega.agregarCompartimiento D55,0
EXEC Bodega.agregarCompartimiento D56,0
EXEC Bodega.agregarCompartimiento D57,0
EXEC Bodega.agregarCompartimiento D58,0
EXEC Bodega.agregarCompartimiento D59,0
EXEC Bodega.agregarCompartimiento D61,0
EXEC Bodega.agregarCompartimiento D62,0
EXEC Bodega.agregarCompartimiento D63,0
EXEC Bodega.agregarCompartimiento D64,0
EXEC Bodega.agregarCompartimiento D65,0
EXEC Bodega.agregarCompartimiento D66,0
EXEC Bodega.agregarCompartimiento D67,0
EXEC Bodega.agregarCompartimiento D68,0
EXEC Bodega.agregarCompartimiento D69,0
EXEC Bodega.agregarCompartimiento D71,0
EXEC Bodega.agregarCompartimiento D72,0
EXEC Bodega.agregarCompartimiento D73,0
EXEC Bodega.agregarCompartimiento D74,0
EXEC Bodega.agregarCompartimiento D75,0
EXEC Bodega.agregarCompartimiento D76,1
EXEC Bodega.agregarCompartimiento D77,0
EXEC Bodega.agregarCompartimiento D78,0
EXEC Bodega.agregarCompartimiento D79,0
EXEC Bodega.agregarCompartimiento D81,0
EXEC Bodega.agregarCompartimiento D82,0
EXEC Bodega.agregarCompartimiento D83,0
EXEC Bodega.agregarCompartimiento D84,0
EXEC Bodega.agregarCompartimiento D85,0
EXEC Bodega.agregarCompartimiento D86,0
EXEC Bodega.agregarCompartimiento D87,0
EXEC Bodega.agregarCompartimiento D88,0
EXEC Bodega.agregarCompartimiento D89,0
EXEC Bodega.agregarCompartimiento E11,0
EXEC Bodega.agregarCompartimiento E12,0
EXEC Bodega.agregarCompartimiento E13,0
EXEC Bodega.agregarCompartimiento E14,0
EXEC Bodega.agregarCompartimiento E15,0
EXEC Bodega.agregarCompartimiento E16,0
EXEC Bodega.agregarCompartimiento E17,0
EXEC Bodega.agregarCompartimiento E18,0
EXEC Bodega.agregarCompartimiento E19,0
EXEC Bodega.agregarCompartimiento E21,0
EXEC Bodega.agregarCompartimiento E22,0
EXEC Bodega.agregarCompartimiento E23,0
EXEC Bodega.agregarCompartimiento E24,0
EXEC Bodega.agregarCompartimiento E25,0
EXEC Bodega.agregarCompartimiento E26,0
EXEC Bodega.agregarCompartimiento E27,0
EXEC Bodega.agregarCompartimiento E28,0
EXEC Bodega.agregarCompartimiento E29,0
EXEC Bodega.agregarCompartimiento E31,0
EXEC Bodega.agregarCompartimiento E32,0
EXEC Bodega.agregarCompartimiento E33,0
EXEC Bodega.agregarCompartimiento E34,0
EXEC Bodega.agregarCompartimiento E35,0
EXEC Bodega.agregarCompartimiento E36,0
EXEC Bodega.agregarCompartimiento E37,0
EXEC Bodega.agregarCompartimiento E38,0
EXEC Bodega.agregarCompartimiento E39,0
EXEC Bodega.agregarCompartimiento E41,0
EXEC Bodega.agregarCompartimiento E42,0
EXEC Bodega.agregarCompartimiento E43,0
EXEC Bodega.agregarCompartimiento E44,0
EXEC Bodega.agregarCompartimiento E45,0
EXEC Bodega.agregarCompartimiento E46,0
EXEC Bodega.agregarCompartimiento E47,0
EXEC Bodega.agregarCompartimiento E48,0
EXEC Bodega.agregarCompartimiento E49,0
EXEC Bodega.agregarCompartimiento E51,0
EXEC Bodega.agregarCompartimiento E52,0
EXEC Bodega.agregarCompartimiento E53,0
EXEC Bodega.agregarCompartimiento E54,0
EXEC Bodega.agregarCompartimiento E55,0
EXEC Bodega.agregarCompartimiento E56,0
EXEC Bodega.agregarCompartimiento E57,0
EXEC Bodega.agregarCompartimiento E58,0
EXEC Bodega.agregarCompartimiento E59,0
EXEC Bodega.agregarCompartimiento E61,0
EXEC Bodega.agregarCompartimiento E62,0
EXEC Bodega.agregarCompartimiento E63,0
EXEC Bodega.agregarCompartimiento E64,0
EXEC Bodega.agregarCompartimiento E65,0
EXEC Bodega.agregarCompartimiento E66,0
EXEC Bodega.agregarCompartimiento E67,0
EXEC Bodega.agregarCompartimiento E68,0
EXEC Bodega.agregarCompartimiento E69,0
EXEC Bodega.agregarCompartimiento E71,0
EXEC Bodega.agregarCompartimiento E72,0
EXEC Bodega.agregarCompartimiento E73,0
EXEC Bodega.agregarCompartimiento E74,0
EXEC Bodega.agregarCompartimiento E75,0
EXEC Bodega.agregarCompartimiento E76,0
EXEC Bodega.agregarCompartimiento E77,0
EXEC Bodega.agregarCompartimiento E78,0
EXEC Bodega.agregarCompartimiento E79,0
EXEC Bodega.agregarCompartimiento E81,0
EXEC Bodega.agregarCompartimiento E82,0
EXEC Bodega.agregarCompartimiento E83,0
EXEC Bodega.agregarCompartimiento E84,0
EXEC Bodega.agregarCompartimiento E85,0
EXEC Bodega.agregarCompartimiento E86,0
EXEC Bodega.agregarCompartimiento E87,0
EXEC Bodega.agregarCompartimiento E88,0
EXEC Bodega.agregarCompartimiento E89,0
EXEC Bodega.agregarCompartimiento F11,0
EXEC Bodega.agregarCompartimiento F12,0
EXEC Bodega.agregarCompartimiento F13,0
EXEC Bodega.agregarCompartimiento F14,0
EXEC Bodega.agregarCompartimiento F15,0
EXEC Bodega.agregarCompartimiento F16,0
EXEC Bodega.agregarCompartimiento F17,0
EXEC Bodega.agregarCompartimiento F18,0
EXEC Bodega.agregarCompartimiento F19,0
EXEC Bodega.agregarCompartimiento F21,0
EXEC Bodega.agregarCompartimiento F22,0
EXEC Bodega.agregarCompartimiento F23,0
EXEC Bodega.agregarCompartimiento F24,0
EXEC Bodega.agregarCompartimiento F25,0
EXEC Bodega.agregarCompartimiento F26,0
EXEC Bodega.agregarCompartimiento F27,0
EXEC Bodega.agregarCompartimiento F28,0
EXEC Bodega.agregarCompartimiento F29,0
EXEC Bodega.agregarCompartimiento F31,0
EXEC Bodega.agregarCompartimiento F32,0
EXEC Bodega.agregarCompartimiento F33,0
EXEC Bodega.agregarCompartimiento F34,0
EXEC Bodega.agregarCompartimiento F35,0
EXEC Bodega.agregarCompartimiento F36,0
EXEC Bodega.agregarCompartimiento F37,0
EXEC Bodega.agregarCompartimiento F38,0
EXEC Bodega.agregarCompartimiento F39,0
EXEC Bodega.agregarCompartimiento F41,0
EXEC Bodega.agregarCompartimiento F42,0
EXEC Bodega.agregarCompartimiento F43,0
EXEC Bodega.agregarCompartimiento F44,0
EXEC Bodega.agregarCompartimiento F45,0
EXEC Bodega.agregarCompartimiento F46,0
EXEC Bodega.agregarCompartimiento F47,0
EXEC Bodega.agregarCompartimiento F48,0
EXEC Bodega.agregarCompartimiento F49,0
EXEC Bodega.agregarCompartimiento F51,0
EXEC Bodega.agregarCompartimiento F52,0
EXEC Bodega.agregarCompartimiento F53,0
EXEC Bodega.agregarCompartimiento F54,0
EXEC Bodega.agregarCompartimiento F55,0
EXEC Bodega.agregarCompartimiento F56,0
EXEC Bodega.agregarCompartimiento F57,0
EXEC Bodega.agregarCompartimiento F58,0
EXEC Bodega.agregarCompartimiento F59,0
EXEC Bodega.agregarCompartimiento F61,0
EXEC Bodega.agregarCompartimiento F62,0
EXEC Bodega.agregarCompartimiento F63,0
EXEC Bodega.agregarCompartimiento F64,0
EXEC Bodega.agregarCompartimiento F65,0
EXEC Bodega.agregarCompartimiento F66,0
EXEC Bodega.agregarCompartimiento F67,0
EXEC Bodega.agregarCompartimiento F68,0
EXEC Bodega.agregarCompartimiento F69,0
EXEC Bodega.agregarCompartimiento F71,0
EXEC Bodega.agregarCompartimiento F72,0
EXEC Bodega.agregarCompartimiento F73,0
EXEC Bodega.agregarCompartimiento F74,0
EXEC Bodega.agregarCompartimiento F75,0
EXEC Bodega.agregarCompartimiento F76,0
EXEC Bodega.agregarCompartimiento F77,0
EXEC Bodega.agregarCompartimiento F78,0
EXEC Bodega.agregarCompartimiento F79,0
EXEC Bodega.agregarCompartimiento F81,0
EXEC Bodega.agregarCompartimiento F82,0
EXEC Bodega.agregarCompartimiento F83,0
EXEC Bodega.agregarCompartimiento F84,0
EXEC Bodega.agregarCompartimiento F85,0
EXEC Bodega.agregarCompartimiento F86,0
EXEC Bodega.agregarCompartimiento F87,0
EXEC Bodega.agregarCompartimiento F88,0
EXEC Bodega.agregarCompartimiento F89,0
EXEC Bodega.agregarCompartimiento G11,0
EXEC Bodega.agregarCompartimiento G12,0
EXEC Bodega.agregarCompartimiento G13,0
EXEC Bodega.agregarCompartimiento G14,0
EXEC Bodega.agregarCompartimiento G15,0
EXEC Bodega.agregarCompartimiento G16,0
EXEC Bodega.agregarCompartimiento G17,0
EXEC Bodega.agregarCompartimiento G18,0
EXEC Bodega.agregarCompartimiento G19,0
EXEC Bodega.agregarCompartimiento G21,0
EXEC Bodega.agregarCompartimiento G22,0
EXEC Bodega.agregarCompartimiento G23,0
EXEC Bodega.agregarCompartimiento G24,0
EXEC Bodega.agregarCompartimiento G25,0
EXEC Bodega.agregarCompartimiento G26,0
EXEC Bodega.agregarCompartimiento G27,0
EXEC Bodega.agregarCompartimiento G28,0
EXEC Bodega.agregarCompartimiento G29,0
EXEC Bodega.agregarCompartimiento G31,0
EXEC Bodega.agregarCompartimiento G32,0
EXEC Bodega.agregarCompartimiento G33,0
EXEC Bodega.agregarCompartimiento G34,0
EXEC Bodega.agregarCompartimiento G35,0
EXEC Bodega.agregarCompartimiento G36,0
EXEC Bodega.agregarCompartimiento G37,0
EXEC Bodega.agregarCompartimiento G38,0
EXEC Bodega.agregarCompartimiento G39,0
EXEC Bodega.agregarCompartimiento G41,0
EXEC Bodega.agregarCompartimiento G42,0
EXEC Bodega.agregarCompartimiento G43,0
EXEC Bodega.agregarCompartimiento G44,0
EXEC Bodega.agregarCompartimiento G45,0
EXEC Bodega.agregarCompartimiento G46,0
EXEC Bodega.agregarCompartimiento G47,0
EXEC Bodega.agregarCompartimiento G48,0
EXEC Bodega.agregarCompartimiento G49,0
EXEC Bodega.agregarCompartimiento G51,0
EXEC Bodega.agregarCompartimiento G52,0
EXEC Bodega.agregarCompartimiento G53,0
EXEC Bodega.agregarCompartimiento G54,0
EXEC Bodega.agregarCompartimiento G55,0
EXEC Bodega.agregarCompartimiento G56,0
EXEC Bodega.agregarCompartimiento G57,0
EXEC Bodega.agregarCompartimiento G58,0
EXEC Bodega.agregarCompartimiento G59,0
EXEC Bodega.agregarCompartimiento G61,0
EXEC Bodega.agregarCompartimiento G62,0
EXEC Bodega.agregarCompartimiento G63,0
EXEC Bodega.agregarCompartimiento G64,0
EXEC Bodega.agregarCompartimiento G65,0
EXEC Bodega.agregarCompartimiento G66,0
EXEC Bodega.agregarCompartimiento G67,0
EXEC Bodega.agregarCompartimiento G68,0
EXEC Bodega.agregarCompartimiento G69,0
EXEC Bodega.agregarCompartimiento G71,0
EXEC Bodega.agregarCompartimiento G72,0
EXEC Bodega.agregarCompartimiento G73,0
EXEC Bodega.agregarCompartimiento G74,0
EXEC Bodega.agregarCompartimiento G75,0
EXEC Bodega.agregarCompartimiento G76,0
EXEC Bodega.agregarCompartimiento G77,0
EXEC Bodega.agregarCompartimiento G78,0
EXEC Bodega.agregarCompartimiento G79,0
EXEC Bodega.agregarCompartimiento G81,0
EXEC Bodega.agregarCompartimiento G82,0
EXEC Bodega.agregarCompartimiento G83,0
EXEC Bodega.agregarCompartimiento G84,0
EXEC Bodega.agregarCompartimiento G85,0
EXEC Bodega.agregarCompartimiento G86,0
EXEC Bodega.agregarCompartimiento G87,0
EXEC Bodega.agregarCompartimiento G88,0
EXEC Bodega.agregarCompartimiento G89,0
EXEC Bodega.agregarCompartimiento H11,0
EXEC Bodega.agregarCompartimiento H12,0
EXEC Bodega.agregarCompartimiento H13,1
EXEC Bodega.agregarCompartimiento H14,0
EXEC Bodega.agregarCompartimiento H15,0
EXEC Bodega.agregarCompartimiento H16,0
EXEC Bodega.agregarCompartimiento H17,0
EXEC Bodega.agregarCompartimiento H18,0
EXEC Bodega.agregarCompartimiento H19,0
EXEC Bodega.agregarCompartimiento H21,0
EXEC Bodega.agregarCompartimiento H22,0
EXEC Bodega.agregarCompartimiento H23,0
EXEC Bodega.agregarCompartimiento H24,0
EXEC Bodega.agregarCompartimiento H25,0
EXEC Bodega.agregarCompartimiento H26,0
EXEC Bodega.agregarCompartimiento H27,0
EXEC Bodega.agregarCompartimiento H28,0
EXEC Bodega.agregarCompartimiento H29,0
EXEC Bodega.agregarCompartimiento H31,0
EXEC Bodega.agregarCompartimiento H32,0
EXEC Bodega.agregarCompartimiento H33,0
EXEC Bodega.agregarCompartimiento H34,0
EXEC Bodega.agregarCompartimiento H35,0
EXEC Bodega.agregarCompartimiento H36,0
EXEC Bodega.agregarCompartimiento H37,0
EXEC Bodega.agregarCompartimiento H38,0
EXEC Bodega.agregarCompartimiento H39,0
EXEC Bodega.agregarCompartimiento H41,0
EXEC Bodega.agregarCompartimiento H42,0
EXEC Bodega.agregarCompartimiento H43,0
EXEC Bodega.agregarCompartimiento H44,0
EXEC Bodega.agregarCompartimiento H45,0
EXEC Bodega.agregarCompartimiento H46,0
EXEC Bodega.agregarCompartimiento H47,0
EXEC Bodega.agregarCompartimiento H48,0
EXEC Bodega.agregarCompartimiento H49,0
EXEC Bodega.agregarCompartimiento H51,0
EXEC Bodega.agregarCompartimiento H52,0
EXEC Bodega.agregarCompartimiento H53,0
EXEC Bodega.agregarCompartimiento H54,0
EXEC Bodega.agregarCompartimiento H55,0
EXEC Bodega.agregarCompartimiento H56,0
EXEC Bodega.agregarCompartimiento H57,0
EXEC Bodega.agregarCompartimiento H58,0
EXEC Bodega.agregarCompartimiento H59,0
EXEC Bodega.agregarCompartimiento H61,0
EXEC Bodega.agregarCompartimiento H62,0
EXEC Bodega.agregarCompartimiento H63,0
EXEC Bodega.agregarCompartimiento H64,0
EXEC Bodega.agregarCompartimiento H65,0
EXEC Bodega.agregarCompartimiento H66,0
EXEC Bodega.agregarCompartimiento H67,0
EXEC Bodega.agregarCompartimiento H68,0
EXEC Bodega.agregarCompartimiento H69,0
EXEC Bodega.agregarCompartimiento H71,0
EXEC Bodega.agregarCompartimiento H72,0
EXEC Bodega.agregarCompartimiento H73,0
EXEC Bodega.agregarCompartimiento H74,0
EXEC Bodega.agregarCompartimiento H75,0
EXEC Bodega.agregarCompartimiento H76,0
EXEC Bodega.agregarCompartimiento H77,0
EXEC Bodega.agregarCompartimiento H78,0
EXEC Bodega.agregarCompartimiento H79,0
EXEC Bodega.agregarCompartimiento H81,0
EXEC Bodega.agregarCompartimiento H82,0
EXEC Bodega.agregarCompartimiento H83,0
EXEC Bodega.agregarCompartimiento H84,0
EXEC Bodega.agregarCompartimiento H85,0
EXEC Bodega.agregarCompartimiento H86,0
EXEC Bodega.agregarCompartimiento H87,0
EXEC Bodega.agregarCompartimiento H88,0
EXEC Bodega.agregarCompartimiento H89,0

EXEC Compra.agregarProveedor 'Textiles Alcacer','Boulevard los procesores, Edificio #4 Poligono #40','2383-9802','alcacerTextil@gmail.com'
EXEC Compra.agregarProveedor 'Variedades Margarita','Mercado central, San Salvador puesto #44','2643-3241','margaritahilos@gmail.com'
EXEC Compra.agregarProveedor 'Dinora´s Tela','Paseo General el escalón edificio #4, contiguo a pollo campero','2908-3221','dinotelas@gmail.com'
EXEC Compra.agregarProveedor 'Textiles la fina','Boulevard los procesores, Edificio #23, local #2','2451-4312','textilesFina@gmail.com'
EXEC Compra.agregarProveedor 'Variedades el cartel','Calle a el puerto de la libertad, en centro comercial la libertad, local #24','2241-2536','varietycartel@gmail.com'
EXEC Compra.agregarProveedor 'Tintas PrintLN','Metrocento,San Salvador contiguo a Raf, local #234','2013-2013','printLnesa@outlook.com'
EXEC Compra.agregarProveedor 'Textufil La libertad','Ciudad Merliot, calle el dolar,Centro comercial Merliot, local #32','2416-2413','textufilLibertad@gmail.com'
EXEC Compra.agregarProveedor 'Textufil San Miguel','Calle de Hotel Florencia, contiguo a Pizza Hut','2416-3215','textufilSanMiguel@gmail.com'
EXEC Compra.agregarProveedor 'Hilo y aguja','Avenida bernal, San Salvador enfrente de COSASE','2361-7513','hiloagujabernal@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Fine','Paseo general Escalón edificio #2, local #654','2163-2451','finetextilescalon@gmail.com'
EXEC Compra.agregarProveedor 'Fabric Fine','Boulevard constitucion, por gasolinera PUMA, edificio #1','2411-2014','fabricfine@gmail.com'
EXEC Compra.agregarProveedor 'Diamond Fabric','Boulevard de los procesores, frente a banco Scotiabank','2383-1234','diamondFabric@gmail.com'
EXEC Compra.agregarProveedor 'Platinum Fabric','Boulevard los soldados, Edificio #4 Poligono #45','2743-3241','platinumgabric@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Salutaris','Boulevard los procesores, Edificio #7 Poligono #48','2523-4335','salutaristela@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Linaza','Boulevard los procesores, Edificio #12 Poligono #54','2341-2555','textileslinaza@gmail.com'
EXEC Compra.agregarProveedor 'Threads Gold','Galerias San Salvador, Edificio #1 Poligono #40, 1º Nivel','2111-1112','theadsgolds@gmail.com'
EXEC Compra.agregarProveedor 'Threads Bold','Soyapango San Salvador,Calle La comunal Poligono #40','7622-1122','hilosgruesos@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Armario','Boulevard los procesores, Edificio #8 Poligono #50','2012-2022','armariotextil@gmail.com'
EXEC Compra.agregarProveedor 'Textiles conacastes','Boulevard la constitucion, Edificio #9 Poligono #2','2432-8032','los_conacastestextil@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Imperio','Galerias Escalón, local #21','2321-4452','textilesImperio@gmail.com'
EXEC Compra.agregarProveedor 'Imperio Real','Las Cascadas, Santa Tecla, local #21','2323-2231','imperiorial@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Unique','Plaza Mundo San Salvador, Local #21, 2º Nivel','2149-2117','txtilUnique@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Dembele','Galerias Escalón, frente a Pollo Real, poligono #2','2789-2122','textildembele@gmail.com'
EXEC Compra.agregarProveedor 'Needle Gold','Ciudad Delgado, calle la brisa edificio verde #12','2721-3221','needlegold@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Sweet','Boulevard la constitucion, Edificio #10, local #1','6751-2121','sweetneedle@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Don Bosco','Boulevard los procesores, Edificio #31 Poligono #21','2123-3212','donBoscoTextil@gmail.com'
EXEC Compra.agregarProveedor 'Variedades Imperio','Mercado central, San Salvador puesto #12','7610-2123','imperiosusa@gmail.com'
EXEC Compra.agregarProveedor 'Dora´s Tela','Paseo General el escalón edificio #7, contiguo a pizza hut','2113-2232','dorastela@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Josefina','Boulevard los procesores, Edificio #99, local #12','6712-4342','textilesjosefina@gmail.com'
EXEC Compra.agregarProveedor 'Variedades la Tenchis','Calle a Cuscatlán, Kilometro #66, Edificio Blanco #89','2692-2556','latenchistelas@gmail.com'
EXEC Compra.agregarProveedor 'Tintas Fortaleza','Metrocento,San Salvador contiguo a panaderia el rosario, local #124','2050-2013','fortaleztinta@outlook.com'
EXEC Compra.agregarProveedor 'Textufil La paz','Ciudad Nuevo Mundo, calle speakers,edificio #90','2098-2086','textufilPaz@gmail.com'
EXEC Compra.agregarProveedor 'Needle and Style','Calle de Hotel Juventus contiguo a Papa John´s','2314-3257','needlestyle@gmail.com'
EXEC Compra.agregarProveedor 'Sant Patricia','Avenida la vega, San Salvador enfrente de China Work','2000-2136','santpatricia@gmail.com'
EXEC Compra.agregarProveedor 'Pintura Fine','Paseo general Escalón Nivel #1, local #98','2190-3246','pinturafine@gmail.com'
EXEC Compra.agregarProveedor 'Tinta Los Santos','Boulevard de los heroes, por Jugueton, edificio #7','2411-2017','los_santos@gmail.com'
EXEC Compra.agregarProveedor 'Needle and Fabric','Boulevard de los procesores, frente a banco Davivienda','2426-3234','needlefabric@gmail.com'
EXEC Compra.agregarProveedor 'Lightning Fabric','Boulevard los soldados, Edificio #72 Poligono #09','6823-3215','lighningfabricESA@gmail.com'
EXEC Compra.agregarProveedor 'Variedades Jeltrudis','Mercado Zacamil,Mejicanos, puesto #55','2983-4343','jeltrudisvariety@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Guzman','Boulevard los procesores, Edificio #64 Poligono #32','2641-2555','textilesguzman@gmail.com'
EXEC Compra.agregarProveedor 'Threads Prime','Galerias San Salvador, Nivel #3 local #42','6109-1112','theadsprime@gmail.com'
EXEC Compra.agregarProveedor 'Threads Falcon','Soyapango San Salvador,Calle hacia Plaza mundo Poligono #48','2083-4321','hilosfalconmaster@gmail.com'
EXEC Compra.agregarProveedor 'Master Textiles','Boulevard los almendros, Edificio #10 Poligono #2','2042-4202','mastertelas@gmail.com'
EXEC Compra.agregarProveedor 'Variedades la Esquinita','Mercado central San salvador, puesto #65','2803-4351','variedadeslaesquinita@gmail.com'
EXEC Compra.agregarProveedor 'Telas Lemus','Galerias Escalón, local #68','2225-4355','telaslemus@gmail.com'
EXEC Compra.agregarProveedor 'El imperio de los hilos','Las Cascadas, Santa Tecla, local #29','6023-3221','imperiothreads@gmail.com'
EXEC Compra.agregarProveedor 'Pinturas la unica','Plaza Mundo San Salvador, Local #29, 1º Nivel','2808-2997','pinturaslaunica@gmail.com'
EXEC Compra.agregarProveedor 'Textiles Coutinho','Galerias Escalón, frente a Pollo bonanza, poligono #7','2942-2563','textilcoutinho@gmail.com'
EXEC Compra.agregarProveedor 'Needle Miguel','Ciudad Delgado, calle el sol edificio amarillo #12','2934-3424','needlemigueESA@gmail.com'
EXEC Compra.agregarProveedor 'Pinturas el Bucanero','Boulevard la constitucion,a tres cuadras despues de Walmart Edificio #10','2314-2319','elbucaneroesa@gmail.com'

EXEC Bodega.agregarMateriaPrima 'Tela Tipo Velvetón',450,750,1,A11,1,1
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Damasco', 500, 600, 1, A12, 1, 1
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Lona', 600, 650, 1, A13, 2, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 200, 500, 1, A14, 3, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 200, 500, 1, A15, 5, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 200, 500, 1, A16, 1, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 300, 500, 1, A17, 6, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 300, 500, 1, A18, 8, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Felpa', 300, 500, 1, A19, 5, 2
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A21, 5, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A22, 8, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A23, 12, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A24, 25, 3
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Gabardina', 600, 800, 1, A25, 27, 3
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A26, 1, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A27, 2, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A28, 3, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A29, 4, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A31, 5, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Nylon', 1200, 8000, 2, A32, 40, 10
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A33, 7, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A34, 6, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A35, 25, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A36, 6, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A37, 12, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A38, 13, 11
EXEC Bodega.agregarMateriaPrima 'Hilo de Poliester', 1500, 8000, 2, A39, 14, 11
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A41, 1, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A42, 2, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A43, 42, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A44, 5, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A45, 7, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A46, 3, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A47, 18, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A48, 19, 5
EXEC Bodega.agregarMateriaPrima 'Tela Tipo Tul', 2000, 2400, 1, A49, 21, 5
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A51, 1, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A52, 2, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A53, 3, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A54, 5, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A55, 25, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A55, 28, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A56, 29, 6
EXEC Bodega.agregarMateriaPrima 'Cordón tipo natuico', 1000, 1400, 3, A57, 7, 6
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A58, 1, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A59, 2, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A61, 3, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A62, 4, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A63, 5, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A64, 6, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 800, 1400, 3, A65, 7, 50
EXEC Bodega.agregarMateriaPrima 'Anilina', 700, 1400, 3, A66, 8, 50

EXEC Compra.agregarEstadoCompras 'Normal'
EXEC Compra.agregarEstadoCompras 'Urgente'
EXEC Compra.agregarEstadoCompras 'Realizada'

EXEC Compra.agregarCompra 100, 1, 1;
EXEC Compra.agregarCompra 50, 1, 2;
EXEC Compra.agregarCompra 20, 1, 3;
EXEC Compra.agregarCompra 100, 1, 4;
EXEC Compra.agregarCompra 200, 1, 5;
EXEC Compra.agregarCompra 140, 1, 6;
EXEC Compra.agregarCompra 100, 1, 7;
EXEC Compra.agregarCompra 150, 1, 8;
EXEC Compra.agregarCompra 200, 1, 9;
EXEC Compra.agregarCompra 120, 1, 10;
EXEC Compra.agregarCompra 200, 1, 11;
EXEC Compra.agregarCompra 200, 1, 12;
EXEC Compra.agregarCompra 150, 1, 13;
EXEC Compra.agregarCompra 30, 1, 14;
EXEC Compra.agregarCompra 3500, 1, 15;
EXEC Compra.agregarCompra 5500, 1, 16;
EXEC Compra.agregarCompra 1520, 1, 17;
EXEC Compra.agregarCompra 2850, 1, 18;
EXEC Compra.agregarCompra 1650, 1, 19;
EXEC Compra.agregarCompra 2520, 1, 20;
EXEC Compra.agregarCompra 3650, 1, 21;
EXEC Compra.agregarCompra 4520, 1, 22;
EXEC Compra.agregarCompra 157, 1, 23;
EXEC Compra.agregarCompra 870, 1, 24;
EXEC Compra.agregarCompra 6080, 1, 25;
EXEC Compra.agregarCompra 4500, 1, 26;
EXEC Compra.agregarCompra 306, 1, 27;
EXEC Compra.agregarCompra 266, 1, 28;
EXEC Compra.agregarCompra 300, 1, 29;
EXEC Compra.agregarCompra 200, 1, 30;
EXEC Compra.agregarCompra 180, 1, 31;
EXEC Compra.agregarCompra 207, 1, 32;
EXEC Compra.agregarCompra 250, 1, 33;
EXEC Compra.agregarCompra 250, 1, 34;
EXEC Compra.agregarCompra 300, 1, 35;
EXEC Compra.agregarCompra 300, 1, 36;
EXEC Compra.agregarCompra 400, 1, 37;
EXEC Compra.agregarCompra 150, 1, 38;
EXEC Compra.agregarCompra 398, 1, 39;
EXEC Compra.agregarCompra 384, 1, 40;
EXEC Compra.agregarCompra 385, 1, 41;
EXEC Compra.agregarCompra 400, 1, 42;
EXEC Compra.agregarCompra 350, 1, 43;
EXEC Compra.agregarCompra 600, 1, 44;
EXEC Compra.agregarCompra 200, 1, 45;
EXEC Compra.agregarCompra 150, 1, 46;
EXEC Compra.agregarCompra 250, 1, 47;
EXEC Compra.agregarCompra 600, 1, 48;
EXEC Compra.agregarCompra 500, 1, 49;
EXEC Compra.agregarCompra 150, 1, 50;

EXEC Produccion.agregarOrdenVenta 1, 5, 1, 42, 1;
EXEC Produccion.agregarOrdenVenta 1, 5, 1, 3, 1;
EXEC Produccion.agregarOrdenVenta 3, 10, 2, 7, 1;
EXEC Produccion.agregarOrdenVenta 4, 28, 3, 6, 1;
EXEC Produccion.agregarOrdenVenta 5, 47, 1, 8, 1;
EXEC Produccion.agregarOrdenVenta 5, 47, 2, 5, 1;
EXEC Produccion.agregarOrdenVenta 7, 30, 2, 6, 1;
EXEC Produccion.agregarOrdenVenta 8, 24, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 9, 46, 1, 2, 1;
EXEC Produccion.agregarOrdenVenta 10, 18, 1, 21, 1;
EXEC Produccion.agregarOrdenVenta 11, 19, 3, 3, 1;
EXEC Produccion.agregarOrdenVenta 12, 1, 2, 2, 1;
EXEC Produccion.agregarOrdenVenta 13, 19, 1, 42, 1;
EXEC Produccion.agregarOrdenVenta 14, 8, 2, 21, 1;
EXEC Produccion.agregarOrdenVenta 15, 9, 1, 19, 1;
EXEC Produccion.agregarOrdenVenta 16, 7, 1, 5, 1;
EXEC Produccion.agregarOrdenVenta 16, 7, 1, 6, 1;
EXEC Produccion.agregarOrdenVenta 16, 7, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 19, 25, 2, 6, 1;
EXEC Produccion.agregarOrdenVenta 20, 7, 2, 7, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 3, 42, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 3, 12, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 2, 21, 1;
EXEC Produccion.agregarOrdenVenta 21, 36, 1, 18, 1;
EXEC Produccion.agregarOrdenVenta 21, 40, 2, 5, 1;
EXEC Produccion.agregarOrdenVenta 26, 7, 1, 8, 1;
EXEC Produccion.agregarOrdenVenta 27, 8, 3, 6, 1;
EXEC Produccion.agregarOrdenVenta 28, 15, 3, 7, 1;
EXEC Produccion.agregarOrdenVenta 29, 21, 1, 21, 1;
EXEC Produccion.agregarOrdenVenta 30, 41, 2, 25, 1;
EXEC Produccion.agregarOrdenVenta 31, 48, 3, 12, 1;
EXEC Produccion.agregarOrdenVenta 32, 15, 1, 42, 1;
EXEC Produccion.agregarOrdenVenta 33, 18, 2, 25, 1;
EXEC Produccion.agregarOrdenVenta 34, 9, 1, 27, 1;
EXEC Produccion.agregarOrdenVenta 34, 9, 3, 1, 1;
EXEC Produccion.agregarOrdenVenta 34, 9, 1, 2, 1;
EXEC Produccion.agregarOrdenVenta 37, 6, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 38, 7, 3, 18, 1;
EXEC Produccion.agregarOrdenVenta 39, 20, 2, 8, 1;
EXEC Produccion.agregarOrdenVenta 39, 20, 1, 12, 1;
EXEC Produccion.agregarOrdenVenta 41, 45, 3, 27, 1;
EXEC Produccion.agregarOrdenVenta 41, 45, 2, 42, 1;
EXEC Produccion.agregarOrdenVenta 43, 37, 1, 18, 1;
EXEC Produccion.agregarOrdenVenta 44, 38, 3, 19, 1;
EXEC Produccion.agregarOrdenVenta 45, 14, 2, 12, 1;
EXEC Produccion.agregarOrdenVenta 46, 17, 3, 27, 1;
EXEC Produccion.agregarOrdenVenta 47, 7, 2, 5, 1;
EXEC Produccion.agregarOrdenVenta 48, 8, 1, 5, 1;
EXEC Produccion.agregarOrdenVenta 49, 26, 2, 6, 1;
EXEC Produccion.agregarOrdenVenta 50, 29, 3, 5, 1;

EXEC Produccion.agregarOrdenVentaTalla 20, 10.5, 17, 5, 1;
EXEC Produccion.agregarOrdenVentaTalla 20, 50, 20, 1, 2;
EXEC Produccion.agregarOrdenVentaTalla 26, 47.8, 37, 2, 3;
EXEC Produccion.agregarOrdenVentaTalla 25, 9, 112, 6, 4;
EXEC Produccion.agregarOrdenVentaTalla 14, 50.6, 186, 4, 5;
EXEC Produccion.agregarOrdenVentaTalla 26, 40, 188, 8, 6;
EXEC Produccion.agregarOrdenVentaTalla 10, 10, 119, 9, 7;
EXEC Produccion.agregarOrdenVentaTalla 40, 74, 96, 1, 8;
EXEC Produccion.agregarOrdenVentaTalla 16, 50, 183, 2, 9;
EXEC Produccion.agregarOrdenVentaTalla 25, 6.5, 72, 11, 10;
EXEC Produccion.agregarOrdenVentaTalla 16, 45.6, 74, 11, 11;
EXEC Produccion.agregarOrdenVentaTalla 14, 80.5, 3, 6, 12;
EXEC Produccion.agregarOrdenVentaTalla 29, 40.5, 75, 3, 13;
EXEC Produccion.agregarOrdenVentaTalla 9, 10, 30, 5, 14;
EXEC Produccion.agregarOrdenVentaTalla 7, 84.5, 36, 7, 15;
EXEC Produccion.agregarOrdenVentaTalla 15, 46, 27, 8, 16;
EXEC Produccion.agregarOrdenVentaTalla 16, 35, 28, 6, 17;
EXEC Produccion.agregarOrdenVentaTalla 31, 28, 26, 1, 18;
EXEC Produccion.agregarOrdenVentaTalla 17, 36, 99, 10, 19;
EXEC Produccion.agregarOrdenVentaTalla 29, 17, 27, 11, 20;
EXEC Produccion.agregarOrdenVentaTalla 8, 25, 141, 4, 21;
EXEC Produccion.agregarOrdenVentaTalla 17, 18, 142, 5, 22;
EXEC Produccion.agregarOrdenVentaTalla 16, 26, 143, 6, 23;
EXEC Produccion.agregarOrdenVentaTalla 32, 18, 144, 5, 24;
EXEC Produccion.agregarOrdenVentaTalla 17, 17, 160, 8, 25;
EXEC Produccion.agregarOrdenVentaTalla 16, 9.01, 28, 9, 26;
EXEC Produccion.agregarOrdenVentaTalla 17, 8.8, 30, 8, 27;
EXEC Produccion.agregarOrdenVentaTalla 16, 19.6, 59, 9, 28;
EXEC Produccion.agregarOrdenVentaTalla 19, 29.6, 83, 8, 29;
EXEC Produccion.agregarOrdenVentaTalla 27, 38.8, 162, 4, 30;
EXEC Produccion.agregarOrdenVentaTalla 18, 25, 189, 5, 31;
EXEC Produccion.agregarOrdenVentaTalla 19, 27, 57, 6, 32;
EXEC Produccion.agregarOrdenVentaTalla 25, 19.8, 71, 4, 33;
EXEC Produccion.agregarOrdenVentaTalla 26, 15.4, 35, 3, 34;
EXEC Produccion.agregarOrdenVentaTalla 9, 16.3, 34, 2, 35;
EXEC Produccion.agregarOrdenVentaTalla 7, 9.5, 33, 1, 36;
EXEC Produccion.agregarOrdenVentaTalla 46, 18.6, 24, 7, 37;
EXEC Produccion.agregarOrdenVentaTalla 8, 34.3, 26, 8, 38;
EXEC Produccion.agregarOrdenVentaTalla 9, 38.4, 80, 9, 39;
EXEC Produccion.agregarOrdenVentaTalla 8, 45.8, 77, 11, 40;
EXEC Produccion.agregarOrdenVentaTalla 7, 6, 177, 1, 41;
EXEC Produccion.agregarOrdenVentaTalla 20, 48, 180, 9, 42;
EXEC Produccion.agregarOrdenVentaTalla 20, 25, 146, 8, 43;
EXEC Produccion.agregarOrdenVentaTalla 16, 14, 151, 7, 44;
EXEC Produccion.agregarOrdenVentaTalla 17, 16, 56, 9, 45;
EXEC Produccion.agregarOrdenVentaTalla 26, 18.6, 67, 6, 46;
EXEC Produccion.agregarOrdenVentaTalla 47, 25.6, 25, 7, 47;
EXEC Produccion.agregarOrdenVentaTalla 59, 14.3, 31, 5, 48;
EXEC Produccion.agregarOrdenVentaTalla 45, 15.6, 104, 6, 49;
EXEC Produccion.agregarOrdenVentaTalla 25, 20.2, 115, 4, 50;