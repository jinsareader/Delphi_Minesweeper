unit mineunit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    RadioButton1: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton3: TRadioButton;
    BitBtn1: TBitBtn;
    procedure RadioButton1Click(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure RadioButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  board_width: integer = 9;
  board_height: integer = 9;
  mine_num: integer = 10;

implementation

{$R *.dfm}

procedure TForm2.RadioButton1Click(Sender: TObject);
begin
  board_width := 9;
  board_height := 9;
  mine_num := 10;
end;

procedure TForm2.RadioButton2Click(Sender: TObject);
begin
  board_width := 16;
  board_height := 16;
  mine_num := 40;
end;

procedure TForm2.RadioButton3Click(Sender: TObject);
begin
  board_width := 30;
  board_height := 16;
  mine_num := 99;
end;

end.
