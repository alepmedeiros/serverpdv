unit server.entities.endereco;

interface

type
  TEndereco = class
  private
    FId: String;
    FEmpresa: String;
    FLogradouro: String;
    FNumero: String;
    FComplemento: String;
    FBairro: String;
    FCidade: String;
    FEstado: String;
    FCep: String;
    FCreatedAt: TDateTIme;
    FUpdatedAt: TDateTime;
  public
    property Id: String read FId write FId;
    property Empresa: String read FEmpresa write FEmpresa;
    property Logradouro: String read FLogradouro write FLogradouro;
    property Numero: String read FNumero write FNumero;
    property Complemento: String read FComplemento write FComplemento;
    property Bairro: String read FBairro write FBairro;
    property Cidade: String read FCidade write FCidade;
    property Estado: String read FEstado write FEstado;
    property Cep: String read FCep write FCep;
    property CreatedAt: TDateTIme read FCreatedAt write FCreatedAt;
    property UpdatedAt: TDateTime read FUpdatedAt write FUpdatedAt;
  end;

implementation

end.
