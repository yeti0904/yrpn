import std.stdio;
import std.string;
import std.uni;
import std.array;
import std.conv;
import core.stdc.stdlib;

class Enviroment {
	Appender!(int[]) stack;

	this() {
		stack = appender!(int[]);
	}

	int Pop() {
		int ret = stack[][stack[].length - 1];
		stack.shrinkTo(stack[].length - 1);
		return ret;
	}

	void GetOperationParameters(int* op1, int* op2) {
		*op2 = Pop();
		*op1 = Pop();
	}

	void Interpret(string input) {
		auto cmds = input.split!isWhite;

		foreach (cmd ; cmds) {
			if (isNumeric(cmd)) {
				stack.put(to!int(cmd[]));
			}
			else {
				switch (cmd) {
					case "+": { // add
						int op1, op2;
						GetOperationParameters(&op1, &op2);

						stack.put(op1 + op2);
						break;
					}
					case "-": { // subtract
						int op1, op2;
						GetOperationParameters(&op1, &op2);

						stack.put(op1 - op2);
						break;
					}
					case "*": { // multiply
						int op1, op2;
						GetOperationParameters(&op1, &op2);

						stack.put(op1 * op2);
						break;
					}
					case "/": { // divide
						int op1, op2;
						GetOperationParameters(&op1, &op2);

						stack.put(op1 / op2);
						break;
					}
					case "p": { // print
						writeln(Pop());
						break;
					}
					case "s": { // stack
						foreach (it ; stack) {
							writeln(it);
						}
						break;
					}
					case "q": { // quit
						return;
					}
					default: {
						if (cmd == "") {
							continue;
						}
						writefln("Unknown command: '%s'", cmd);
						exit(1);
					}
				}
			}
		}
	}
}
