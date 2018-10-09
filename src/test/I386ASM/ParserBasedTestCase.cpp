#include "test/I386ASM/ParserBasedTestCase.hpp"

#include "sys/stream/StreamFactory.hpp"
#include "sys/stream/IgnoreOStream.hpp"
#include "I386ASM/ASMInstructionList.hpp"

// public
ParserBasedTestCase::ParserBasedTestCase(Environment &env, MemoryInfo &mi): TestCase(env, mi), parser(env.create<Parser>()) {}
ParserBasedTestCase::~ParserBasedTestCase() {
    parser.destroy();
}

// protected
ASMInstructionList & ParserBasedTestCase::parseSilent(IStream & input, String & errorBuffer) {
    IgnoreOStream ignore(env());
    OStream &outOrig = env().setOut(ignore); 
    OStream &errOrig = env().setErr(ignore);
    
    ASMInstructionList &list = parser.parse(input, errorBuffer);
    
    env().setOut(outOrig);
    env().setErr(errOrig);
    
    return list;
}

bool ParserBasedTestCase::test(const char * input, const char * expectedBinary, const char * expectedPretty, const char * message, size_t startAddress, const char * dumpBinary) {
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
        mes << "test \"" << input << '"';
    }
    return test(in, bin, pretty, mes, startAddress, dumpBinary);
}

bool ParserBasedTestCase::test(String & input, String & expectedBinary, String & expectedPretty, String & message, size_t startAddress, const char * dumpBinary) {
    String buffer(env());
    String errorBuffer(env());
    {
        IStream &in = input.toIStream();
        ASMInstructionList &list = parseSilent(in, errorBuffer);
        assertFalse(list.hasErrors(), message<<" parsing error:\n"<<errorBuffer );
        if (errorBuffer != "") { env().err()<<errorBuffer; errorBuffer = "";}
        
        list.compile();
        assertFalse(list.hasErrors(), message<<" preparation error:\n"<<errorBuffer );
        if (errorBuffer != "") { env().err()<<errorBuffer; errorBuffer = "";}
        
        list.logToStream(buffer="");
        assertEquals(buffer, expectedPretty, "pretty print: "<<message );
        
        list.finalize(startAddress);
        assertFalse(list.hasErrors(), message<<" finalization error:\n"<<errorBuffer );
        if (errorBuffer != "") { env().err()<<errorBuffer; errorBuffer = "";}
        
        if (dumpBinary) {
            OStream &dump = env().streamFactory().buildOStream(dumpBinary);
            list.writeToStream(dump);
            dump.destroy();
        }
        
        list.writeToStream(buffer="");
        assertEquals(buffer, expectedBinary, "binary: "<<message );
        
        list.destroy();
        in.destroy();
    }
    {
        IStream &in = expectedPretty.toIStream();
        ASMInstructionList &list = parseSilent(in, errorBuffer);
        assertFalse(list.hasErrors(), message<<" stable parsing error:\n"<<errorBuffer );
        if (errorBuffer != "") { env().err()<<errorBuffer; errorBuffer = "";}
        
        list.compile();
        assertFalse(list.hasErrors(), message<<" stable preparation error:\n"<<errorBuffer );
        if (errorBuffer != "") { env().err()<<errorBuffer; errorBuffer = "";}
        
        list.logToStream(buffer="");
        assertEquals(buffer, expectedPretty, "stable pretty print: "<<message );
        
        list.finalize(startAddress);
        assertFalse(list.hasErrors(), message<<" stable finalization error:\n"<<errorBuffer );
        if (errorBuffer != "") { env().err()<<errorBuffer; errorBuffer = "";}
        
        list.writeToStream(buffer="");
        assertEquals(buffer, expectedBinary, "stable binary: "<<message );
        
        list.destroy();
        in.destroy();
    }
    
    successText(message);
}
