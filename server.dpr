program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.jhonson,
  Horse.OctetStream,
  System.SysUtils,
  server.connections.interfaces in 'src\connections\server.connections.interfaces.pas',
  server.connections.impl.firedac in 'src\connections\impl\server.connections.impl.firedac.pas';

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse
    .Use(jhonson)
    .Use(OctetStream);

  THorse.Listen(9000);
end.
