#include "test/I386ASM/ParserBasedTestCase.hpp"

#include "I386ASM/ASMInstructionList.hpp"

// public
ParserBasedTestCase::ParserBasedTestCase(Environment &env, MemoryInfo &mi): TestCase(env, mi), parser(env.create<Parser>()) {}
ParserBasedTestCase::~ParserBasedTestCase() {
    parser.destroy();
}

// protected
ASMInstructionList & ParserBasedTestCase::parseSilent(IStream & input, String & errorBuffer) {
    String outBuffer(env());
    OStream &outOrig = env().setOut(outBuffer); 
    OStream &errOrig = env().setErr(errorBuffer);
    
    ASMInstructionList &list = parser.parse(input);
    
    env().setOut(outOrig);
    env().setErr(errOrig);
    
    return list;
}

bool ParserBasedTestCase::test(const char * input, const char * expectedBinary, const char * expectedPretty, const char * message) {
    String in(env(), *notAnInfo, input);
    String bin(env(), *notAnInfo, expectedBinary);
    String pretty(env());
    if (expectedPretty) {
        pretty << expectedPretty;
    } else {
        pretty << input << '\n';
    }
    String mes(env());
    if (message) {
        mes << message;
    } else {
        mes << '"' << input << "\"-Test";
    }
    return test(in, bin, pretty, mes);
}

bool ParserBasedTestCase::test(String & input, String & expectedBinary, String & expectedPretty, String & message) {
    String buffer(env());
    {
        IStream &in = input.toIStream();
        ASMInstructionList &list = parseSilent(in, buffer="");
        assertEquals(buffer, "", "parsing error" );
        bool success = list.prepare(buffer="");
        assert(success && (buffer == ""), "preparation error: "<<buffer );
        
        list.logToStream(buffer="");
        assertEquals(buffer, expectedPretty, "pretty print: "<<message );
        
        list.writeToStream(buffer="");
        assertEquals(buffer, expectedBinary, "binary: "<<message );
        
        list.destroy();
        in.destroy();
    }
    {
        IStream &in = expectedPretty.toIStream();
        ASMInstructionList &list = parseSilent(in, buffer="");
        assertEquals(buffer, "", "parsing error" );
        bool success = list.prepare(buffer="");
        assert(success && (buffer == ""), "preparation error: "<<buffer );
        
        list.logToStream(buffer="");
        assertEquals(buffer, expectedPretty, "stable pretty print: "<<message );
        
        list.writeToStream(buffer="");
        assertEquals(buffer, expectedBinary, "stable binary: "<<message );
        
        list.destroy();
        in.destroy();
    }

    successText(message);
}
