#!/bin/sh
#source build-esen.sh

# if gradle home dir is not set use subdir in wercker cached dir
if [ -z "${GRADLE_USER_HOME}" ]; then
	export GRADLE_USER_HOME="${WERCKER_CACHE_DIR}/gradle/"
fi
mkdir -p ${GRADLE_USER_HOME}

# check tasks argument
if [ -z "${WERCKER_GRADLE_TASKS}" ]; then
	fail "Please provide a Gradle tasks"
fi

function g_install() {
	# if no version is provided use the default - current
	if [ -z "${WERCKER_GRADLE_VERSION}" ]; then
		info "Detect current gradle version"
		export WERCKER_GRADLE_VERSION=$(curl --silent https://services.gradle.org/versions/current | grep '"version"' | cut -d '"' -f4)
		info "Use gradle ${WERCKER_GRADLE_VERSION}"
	fi

	# download if not exists
	G_DOWNLOAD_ROOT=${GRADLE_USER_HOME}/wercker/
	G_DOWNLOAD_TARGET=${G_DOWNLOAD_ROOT}/gradle-${WERCKER_GRADLE_VERSION}-bin.zip
	G_DOWNLOAD_URL=https://services.gradle.org/distributions/gradle-${WERCKER_GRADLE_VERSION}-bin.zip
	if [ ! -f ${G_DOWNLOAD_TARGET} ]; then
		curl ${G_DOWNLOAD_URL} --output ${G_DOWNLOAD_TARGET}
		unzip ${G_DOWNLOAD_TARGET}.zip -d ${G_DOWNLOAD_ROOT}
	fi

	# add to PATH
	export PATH=${G_DOWNLOAD_ROOT}/gradle-${WERCKER_GRADLE_VERSION}/bin:${PATH}

	# show gradle version
	gradle --version
}

if [ -f ./gradlew ]; then
	debug "Use gradle wrapper from project"

	# check execution bit
	if [ ! -x ./gradlew ]; then
		warn "Gradle wrapper runner 'gradlew' does not have execution bit. You shoud set this bit, check http://stackoverflow.com/a/33820642"
		chmod u+x ./gradlew
	fi

	G_RUNNER=./gradlew
else
	debug "Use standalone gradle distribution"

	# install gradle
	g_install

	G_RUNNER=gradle
fi

# some opts
G_OPTS=--no-search-upward

# run gradle
${G_RUNNER} ${G_OPTS} ${WERCKER_GRADLE_TASKS}
