// Copyright 2016 iAchieved.it LLC MIT License
import Glibc

extension String {
  subscript (r: CountableClosedRange<Int>) -> String {
    get {
      let startIndex = self.characters.index(self.characters.startIndex, offsetBy:r.lowerBound)
      let endIndex   = self.characters.index(self.characters.startIndex, offsetBy:r.upperBound)
      return self[startIndex..<endIndex]
    }
  }
}

func exec(_ command:String) -> String {
  let BUFSIZE = 128
  let pipe = popen(command, "r")
  var buf  = [CChar](repeating:CChar(0), count:BUFSIZE)
  var output:String = ""
  while fgets(&buf, Int32(BUFSIZE), pipe) != nil {
    output = String(cString:buf)
  }
  return output
}

func gitRevision(_ directory:String) -> String {

  let cwd     = String(cString:getcwd(nil, 0))
  let rc      = chdir(directory)
  
  guard rc == 0 else {
    return "ERROR"
  }
  
  var rev = exec("/usr/bin/git rev-parse HEAD")
  rev = rev[0...9]

  chdir(cwd)

  return rev
}

func gitFetchURL(_ dirname:String) -> String {
  let cwd     = String(cString:getcwd(nil, 0))
  let rc      = chdir(dirname)
  
  guard rc == 0 else {
    return "ERROR"
  }
  
  let url = exec("/usr/bin/git remote show origin -n|grep Fetch| echo -n `cut --characters=14-`")
  
  chdir(cwd)
  
  return url
}

func gitBranch(_ dirname:String) -> String {
  let cwd     = String(cString:getcwd(nil, 0))
  let rc      = chdir(dirname)

  guard rc == 0 else {
    return "ERROR"
  }

  let url  = exec("/usr/bin/git branch | echo -n `cut --characters=2-`")
  chdir(cwd)

  return url
}

let dirs = ["swift", "llvm", "clang", "lldb", "compiler-rt", "cmark", "llbuild", "swiftpm", "swift-corelibs-xctest", "swift-corelibs-foundation", "swift-integration-tests", "swift-corelibs-libdispatch"]

for dir in dirs {
  let fetch  = gitFetchURL(dir)
  let rev    = gitRevision(dir)
  let branch = gitBranch(dir)
  print("\(dir),\(fetch),\(branch),\(rev)")
}
