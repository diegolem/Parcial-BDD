-- Creacion de errores //////////////////////////////////////////////////////////////////////////////
exec sp_dropmessage 50018
exec sp_dropmessage 50019
exec sp_dropmessage 50020

exec sp_addmessage 50018, 20,  N'No se puede actualizar el estado pues el proceso anterior no ha sido completado', 'us_english'
exec sp_addmessage 50019, 21,  N'No se puede seleccionar un processo que no sea de la misma variante', 'us_english'
exec sp_addmessage 50020, 22,  N'No existe la suficiente tela para la ordeb', 'us_english'
