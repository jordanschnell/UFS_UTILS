help([[
Load environment to compile UFS_UTILS snow2mdl on Orion
]])

prepend_path("MODULEPATH", "/apps/contrib/NCEP/libs/hpc-stack/modulefiles/stack")

hpc_ver=os.getenv("hpc_ver") or "1.1.0"
load(pathJoin("hpc", hpc_ver))

hpc_intel_ver=os.getenv("hpc_intel_ver") or "2020.2"
load(pathJoin("hpc-intel", hpc_intel_ver))

ip_ver=os.getenv("ip_ver") or "3.3.3"
load(pathJoin("ip", ip_ver))

sp_ver=os.getenv("sp_ver") or "2.3.3"
load(pathJoin("sp", sp_ver))

landsfcutil_ver=os.getenv("landsfcutil_ver") or "2.4.1"
load(pathJoin("landsfcutil", landsfcutil_ver))

w3nco_ver=os.getenv("w3nco_ver") or "2.4.1"
load(pathJoin("w3nco", w3nco_ver))

bacio_ver=os.getenv("bacio_ver") or "2.4.1"
load(pathJoin("bacio", bacio_ver))

g2_ver=os.getenv("g2_ver") or "3.4.4"
load(pathJoin("g2", g2_ver))

jasper_ver=os.getenv("jasper_ver") or "2.0.25"
load(pathJoin("jasper", jasper_ver))
setenv("JASPER_LIB","${JASPER_LIBRARIES}/libjasper.a")

libpng_ver=os.getenv("libpng_ver") or "1.6.35"
load(pathJoin("png", libpng_ver))
setenv("PNG_LIB","${PNG_ROOT}/lib64/libpng.a")

zlib_ver=os.getenv("zlib_ver") or "1.2.11"
load(pathJoin("zlib", zlib_ver))
setenv("Z_LIB","${ZLIB_LIBRARIES}/libz.a")

setenv("FCOMP","ifort")
setenv("FFLAGS","-O0 -r8 -i4 -FR -I${IP_INCd} -qopenmp -convert big_endian -assume byterecl")

whatis("Description: UFS_UTILS snow2mdl build environment")