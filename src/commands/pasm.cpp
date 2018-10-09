#include "linux/LinuxBootstrap.hpp"
#include "linux/CommandLine.hpp"

#include "I386ASM/Parser.hpp"

static const char VERSION[] = "pasm 0.1.0";
static const char USAGE[] =
R"(Pool Assembler.

    Usage:
      pasm [options] -o <file> <file>

    Options:
      -h --help    Show this screen.
      --version    Show version.
      -o <file>    Place the output into <file>.
      -b --binary  Generate plain binary without module informations.
)";

class PasmCommand: public CommandLine {
    private:
    Parser &parser;
    
    public:
    PasmCommand(Environment & env, MemoryInfo & mi = *notAnInfo)
            :CommandLine(env, mi), Object(env, mi), parser(env.create<Parser>()) {
    }
    virtual ~PasmCommand() {
        parser.destroy();
    }
    
    int run(int argc, char* argv[]) {
        parse(argc, argv);
        
        if (hasProperty("h") || hasProperty("help")) {
            env().out()<<USAGE;
            return 0;
        }
        if (hasProperty("version")) {
            env().out()<<VERSION<<"\n";
            return 0;
        }
        if (!hasStringProperty("o") || _arguments.size() != 1) {
            env().out()<<USAGE;
            return -1;
        }
        size_t startAddress = 0;
        
        OStream &outfile = env().streamFactory().buildOStream(getStringProperty("o"));
        Iterator<String> & argIt = arguments();
        IStream &infile = env().streamFactory().buildIStream(argIt.next());
        argIt.destroy();
        
        ASMInstructionList &list = parser.parse(infile, env().err());
        if (list.hasErrors()) { return 1; }
        
        list.compile();
        if (list.hasErrors()) { return 1; }
        
        list.finalize(startAddress);
        if (list.hasErrors()) { return 1; }

        // generate module infos
        if (!hasProperty("b") && !hasProperty("binary")) {
            outfile
                <<"/*[meta]\n"
                <<"mimetype = application/x-bin-x86\n"
                //<<"description = Dies ist das GridOS-Kernel-Modul \"Blinking\"\n"
                //<<"[pool]\n"
                //<<"version = 0.1.0\n"
                <<"*/\n";
        }
        list.writeToStream(outfile);
        
        infile.destroy();
        outfile.destroy();
        list.destroy();
    }
};

int main(int argc, char* argv[]) {
    PasmCommand command(LinuxBootstrap::buildEnvironment());
    return command.run(argc, argv);
}
