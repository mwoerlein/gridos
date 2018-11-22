#include "linux/LinuxBootstrap.hpp"
#include "linux/CommandLine.hpp"

#include "I386ASM/Parser.hpp"

static const char VERSION[] = "store 0.1.0";
static const char USAGE[] =
R"(GridOS Storage Builder.

    Usage:
      store [options] -o <file> <file>...

    Options:
      -h --help    Show this screen.
      --version    Show version.
      -o <file>    Place the store into <file>.
      -a <align>   Ensure that storage size is a multiple of align.
)";

class StoreCommand: public CommandLine {
    private:
    
    public:
    StoreCommand(Environment & env, MemoryInfo & mi = *notAnInfo)
            :CommandLine(env, mi), Object(env, mi) {
    }
    virtual ~StoreCommand() {
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
        if (!hasStringProperty("o") || _arguments.size() == 0) {
            env().out()<<USAGE;
            return -1;
        }
        
        SeekableOStream &outfile = env().streamFactory().buildOStream(getStringProperty("o"));
        outfile<<"/*[meta]\n";
        outfile<<"mimetype = application/grid-store\n";
        outfile<<"*/\n";

        size_t index = outfile.pos();
        for (int i = _arguments.size(); i >= 0; i--) {
            outfile.rawInt(0).rawInt(0);
        }
        
        Iterator<String> & argIt = arguments();
        while (argIt.hasNext()) {
            String &name = argIt.next();
            SeekableIStream &infile = env().streamFactory().buildIStream(name);
            size_t start = outfile.pos();
            size_t size = infile.length();
//            env().out()<<"store "<<name<<" at "<<mark<<":"<<size<<" "<<indexEnd<<'\n';
            outfile.seek(index);
            outfile.rawInt(start).rawInt(size);
            index = outfile.pos();
            outfile.seek(start);
            outfile << infile;
            infile.destroy();
        }
        argIt.destroy();
        
        if (hasStringProperty("a")) {
            int align;
            getStringProperty("a") >> align;
            while (outfile.pos() % align) {
                outfile.rawChar(0);
            }
        }

        outfile.destroy();
    }
};

int main(int argc, char* argv[]) {
    StoreCommand command(LinuxBootstrap::buildEnvironment());
    return command.run(argc, argv);
}
