init:
	killall Xcode
	pod install
	open carr.xcworkspace

update:
	killall Xcode
	git pull
	open carr.xcworkspace

clean:
	killall Xcode
	rm Podfile.lock
	rm -R carr.xcworkspace
	rm -R Pods
	make update
