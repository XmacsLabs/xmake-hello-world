set_allowedplats("linux", "macosx", "mingw", "wasm", "windows")

if is_plat("mingw") and is_host("windows") then
    add_requires("mingw-w64 8.1.0")
    set_toolchains("mingw@mingw-w64")
end

if is_plat("wasm") then
    add_requires("emscripten")
    set_toolchains("emcc@emscripten")
end

add_rules("mode.debug", "mode.release")

add_requires("doctest 2.4.11", {system=false})

target("hello")
    set_kind("binary")
    add_files("src/*.c")

    if is_plat("wasm") then
        add_cxxflags("-s DISABLE_EXCEPTION_CATCHING=0")
        add_ldflags("-s DISABLE_EXCEPTION_CATCHING=0")
        on_run(function (target)
            cmd = "node $(buildir)/wasm/wasm32/$(mode)/hello.js"
            print("> " .. cmd)
            os.exec(cmd)
        end)
    end
