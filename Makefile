install:
	make install

open:
	open scaffold.xcodeproj

clean:
	rm -rf node_modules

start-server:
	node index.js
