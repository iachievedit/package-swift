import Glibc

extension String {
  subscript (r: Range<Int>) -> String {
    get {
      let startIndex = self.startIndex.advancedBy(r.startIndex)
      let endIndex   = self.startIndex.advancedBy(r.endIndex)
            
      return self[Range(start: startIndex, end: endIndex)]
    }
  }
}

func getGitRevision(dirname:String) -> String {
  let BUFSIZE = 128
  let cwd     = String.fromCString(getcwd(nil, 0))!
  let rc      = chdir(dirname)
  
  guard rc == 0 else {
    return "ERROR"
  }
  
  var rev  = ""
  let pipe = popen("/usr/bin/git rev-parse HEAD", "r")
  var buf  = [CChar](count:BUFSIZE, repeatedValue:CChar(0))
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    rev = String.fromCString(buf)!
  }
  rev = rev[0...9]

  chdir(cwd)

  return rev
}

let dirs = ["swift", "llvm", "clang", "lldb", "cmark", "llbuild", "swiftpm", "swift-corelibs-xctest", "swift-corelibs-foundation", "swift-integration-tests"]

for dir in dirs {
  let rev = getGitRevision(dir)
  print("\(dir):\(rev)")
}
