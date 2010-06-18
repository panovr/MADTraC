include(${MT_ROOT}/cmake/MT_Exports.cmake)

include_directories(${MT_INCLUDE})
if(IS_DIRECTORY ${MT_INCLUDE})
else()  
  message(SEND_ERROR "Couldn't find MADTraC includes")
endif()
if(IS_DIRECTORY ${MT_LIBS_DIR})
else()  
  message(SEND_ERROR "Couldn't find MADTraC libraries directory")
endif()  

if(${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${WX_LIB} -framework AGL -framework OpenGL -framework Quicktime -framework AppKit -framework Carbon -framework IOKit /opt/local/lib/libiconv.a /opt/local/lib/libz.a")
endif()  

include_directories(${MT_WX_INCLUDE})
set(CMAKE_EXE_LINKER_FLAGS "${CMAKE_EXE_LINKER_FLAGS} ${MT_WX_LIB}")

if(MT_HAVE_CLF)
  include_directories(${MT_CLF_INCLUDE} ${MT_HDF5_INCLUDE})
endif(MT_HAVE_CLF)  

if(MT_HAVE_OPENCV AND NOT MT_OPENCV_FRAMEWORK)
  set(MT_OPENCV_INC ${OPENCV_ROOT}/cv/include)
  set(MT_OPENCV_LIB_DIR ${OPENCV_ROOT}/lib)
  if(WIN32)
    if(EXISTS ${OPENCV_ROOT}/lib/cxcore200.lib)
      set(MT_OPENCV_LIBS cxcore200.lib highgui200.lib cv200.lib cvaux200.lib)
    else()
      set(MT_OPENCV_LIBS cxcore.lib highgui.lib cv.lib cvaux.lib)
    endif()
  else(WIN32)
    # TODO
  endif(WIN32)
  link_directories(${MT_OPENCV_LIB_DIR})  
endif()

