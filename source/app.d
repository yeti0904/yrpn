import std.stdio;
import std.string;
import std.file;
import core.stdc.stdlib;

import interpreter;

void main(string[] args) {
	const string help = "
Usage: path/to/yrpn <file> <-h/--help>
	";

	string     input;
	bool       run = true;
	Enviroment env = new Enviroment();
	bool       runShell = true;

	for (size_t i = 1; i < args.length; ++i) {
		if (args[i][0] == '-') {
			switch (args[i]) {
				case "-h":
				case "--help": {
					writeln(help);
					break;
				}
				default: {
					writeln("Unrecognised parameter: " ~ args[i]);
					exit(1);
				}
			}
		}
		else {
			string script;
			try {
				script = readText(args[i]);
			}
			catch (FileException e) {
				writefln("%s:%i: %s", e.file, cast(int) e.line, e.msg);
				exit(1);
			}
			env.Interpret(script);
			exit(1);
		}
	}

	while (run) {
		write("> ");
		input = readln();
		run   = input != "q\n";
		if (run) {
			env.Interpret(chop(input));
		}
	}

	env.destroy();
}
