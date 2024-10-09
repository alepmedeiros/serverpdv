unit server.entities.emissorfiscal;

interface

uses
  System.Classes;

type
  TEmissorFiscal = class
  private
    FId: String;
    FEmpresa: String;
    FTipoDoumentoFiscal: String;
    FAmbiente: String;
    FSerie: String;
    FNumero: String;
    FTipoEmissao: String;
    FTipoSped: String;
    FCertificado: TStream;
    FSenha: String;
  public
    property Id: String read FId write FId;
    property Empresa: String read FEmpresa write FEmpresa;
    property TipoDoumentoFiscal: String read FTipoDoumentoFiscal write FTipoDoumentoFiscal;
    property Ambiente: String read FAmbiente write FAmbiente;
    property Serie: String read FSerie write FSerie;
    property Numero: String read FNumero write FNumero;
    property TipoEmissao: String read FTipoEmissao write FTipoEmissao;
    property TipoSped: String read FTipoSped write FTipoSped;
    property Certificado: TStream read FCertificado write FCertificado;
    property Senha: String read FSenha write FSenha;
  end;

implementation

end.
