import Cocoa
import CoreMIDI
import PlaygroundSupport

func getDisplayName(_ obj: MIDIObjectRef) -> String
{
    var param: Unmanaged<CFString>?
    var name: String = "Error"
    
    let err: OSStatus = MIDIObjectGetStringProperty(obj, kMIDIPropertyDisplayName, &param)
    if err == OSStatus(noErr)
    {
        name =  param!.takeRetainedValue() as String
    }
    
    return name
}

func getDestinationNames() -> [String]
{
    var names:[String] = [];
    
    let count: Int = MIDIGetNumberOfDestinations();
    for i in 0..<count {
        let endpoint:MIDIEndpointRef = MIDIGetDestination(i);
        
        if (endpoint != 0)
        {
            names.append(getDisplayName(endpoint));
        }
    }
    return names;
}

func getSourceNames() -> [String]
{
    var names:[String] = [];
    
    let count: Int = MIDIGetNumberOfSources();
    for i in 0..<count {
        let endpoint:MIDIEndpointRef = MIDIGetSource(i);
        if (endpoint != 0)
        {
            names.append(getDisplayName(endpoint));
        }
    }
    return names;
}

let destNames = getDestinationNames();

print("Number of MIDI Destinations: \(destNames.count)");
for destName in destNames
{
    print("  Destination: \(destName)");
}

let sourceNames = getSourceNames();

print("\nNumber of MIDI Sources: \(sourceNames.count)");
for sourceName in sourceNames
{
    print("  Source: \(sourceName)");
}