set_allowedplats("linux", "macosx", "mingw", "wasm", "windows")

if is_plat("mingw") and is_host("windows") then
    add_requires("mingw-w64 8.1.0")
    set_toolchains("mingw@mingw-w64")
end

add_rules("mode.debug", "mode.release")

target("hello")
    set_kind("binary")
    add_files("src/*.c")

