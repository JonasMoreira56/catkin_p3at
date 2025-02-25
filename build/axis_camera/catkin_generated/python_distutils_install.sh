#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/home/jonas/catkin_p3at/src/axis_camera"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/jonas/catkin_p3at/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/jonas/catkin_p3at/install/lib/python3/dist-packages:/home/jonas/catkin_p3at/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/jonas/catkin_p3at/build" \
    "/usr/bin/python3" \
    "/home/jonas/catkin_p3at/src/axis_camera/setup.py" \
    egg_info --egg-base /home/jonas/catkin_p3at/build/axis_camera \
    build --build-base "/home/jonas/catkin_p3at/build/axis_camera" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/jonas/catkin_p3at/install" --install-scripts="/home/jonas/catkin_p3at/install/bin"
