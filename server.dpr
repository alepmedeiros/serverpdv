program server;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.jhonson,
  Horse.OctetStream,
  System.SysUtils,
  server.connections.interfaces in 'src\connections\server.connections.interfaces.pas',
  server.connections.impl.firedac in 'src\connections\impl\server.connections.impl.firedac.pas',
  server.entities.empresa in 'src\entities\server.entities.empresa.pas',
  server.entities.endereco in 'src\entities\server.entities.endereco.pas',
  server.entities.emissorfiscal in 'src\entities\server.entities.emissorfiscal.pas',
  service.repository.interfaces in 'src\repository\service.repository.interfaces.pas',
  service.repository.impl.empresa in 'src\repository\impl\service.repository.impl.empresa.pas';

begin
  {$IFDEF DEBUG}
  ReportMemoryLeaksOnShutdown := True;
  {$ENDIF}

  THorse
    .Use(jhonson)
    .Use(OctetStream);

  THorse.Listen(9000);
end.
