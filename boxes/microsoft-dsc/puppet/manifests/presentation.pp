# File TestFile {
#   Ensure = "Present"
#   Contents = "Hi! testcontent"
#   DestinationPath = "c:\testdsc\test.txt"
# }

file {'c:/testdsc/test.txt':
  ensure  => 'file',
  content => 'Hi! testcontent',
}
