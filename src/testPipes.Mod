MODULE testPipes;
IMPORT pipes, Out;

PROCEDURE test;
VAR
  cmd: ARRAY 64 OF CHAR;
  name: ARRAY 64 OF CHAR;
  text: pipes.Text;
  ch: CHAR;
  l: LONGINT;
BEGIN
  COPY("ls -al", cmd);
  text := pipes.NewText();
  pipes.Popen(text, cmd, 'r');
  WHILE ~ text.eof DO
  (*WHILE ~pipes.isEOF(text) DO*)
    pipes.Read(text, ch);
    Out.Char(ch);
  END;
  (*pipes.ReadLine(text, name);*)
  l := pipes.Pclose(text);
  (*Out.String(name); Out.Ln;*)
  Out.Int(l, 0); Out.Ln;


END test;

BEGIN
  test


END testPipes.
