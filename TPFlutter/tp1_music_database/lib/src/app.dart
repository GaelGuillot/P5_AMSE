 
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'data.dart';
import 'screens/artist_details.dart';
import 'screens/artists.dart';
import 'screens/music_details.dart';
import 'screens/musics.dart';
import 'screens/scaffold.dart';
import 'screens/about.dart';
import 'widgets/music_list.dart';
import 'widgets/fade_transition_page.dart';

final appShellNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'app shell');
final musicsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'musics shell');

class Bookstore extends StatefulWidget {
  const Bookstore({super.key});

  @override
  State<Bookstore> createState() => _BookstoreState();
}

class _BookstoreState extends State<Bookstore> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        debugLogDiagnostics: true,
        initialLocation: '/musics/all',
        routes: [
          ShellRoute(
            navigatorKey: appShellNavigatorKey,
            builder: (context, state, child) {
              return BookstoreScaffold(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith('/musics') => 0,
                  var p when p.startsWith('/artists') => 1,
                  var p when p.startsWith('/settings') => 2,
                  _ => 0,
                },
                child: child,
              );
            },
            routes: [
              ShellRoute(
                pageBuilder: (context, state, child) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(
                      builder: (context) {
                        return MusicsScreen(
                          onTap: (idx) {
                           
                            GoRouter.of(context).go(switch (idx) {
                              0 => '/musics/all',
                              1 => '/musics/rap',
                              2 => '/musics/rock',
                              3 => '/musics/pop',
                              4 => '/musics/jazz',
                              5 => '/musics/favorites',
                              _ => '/musics/all',
                            });

                          },
                          
                          selectedIndex: switch (state.uri.path) {
                            var p when p.startsWith('/musics/all') => 0,
                            var p when p.startsWith('/musics/rap') => 1,
                            var p when p.startsWith('/musics/rock') => 2,
                            var p when p.startsWith('/musics/pop') => 3,
                            var p when p.startsWith('/musics/jazz') => 4,
                            var p when p.startsWith('/musics/favorites') => 5,
                            _ => 0,
                          },
                          child: child,
                        );
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: '/musics/favorites',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            if (libraryInstance.favoriteMusics.length > 0) {
                              return MusicList(
                                musics: libraryInstance.favoriteMusics,
                                onTap: (music) {
                                  GoRouter.of(
                                    context,
                                  ).go('/musics/all/music/${music.id}');
                                },
                              );
                            } else {
                              return Center(
                                child: Text('No musics yet!', style: Theme.of(context).textTheme.headlineMedium),
                                );            
                            }
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'music/:musicId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MusicDetailsScreen(
                            music: libraryInstance.getMusic(
                              state.pathParameters['musicId'] ?? '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/musics/rap',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return MusicList(
                              musics: libraryInstance.rapMusic,
                              onTap: (music) {
                                GoRouter.of(
                                  context,
                                ).go('/musics/all/music/${music.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'music/:musicId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MusicDetailsScreen(
                            music: libraryInstance.getMusic(
                              state.pathParameters['musicId'] ?? '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/musics/rock',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return MusicList(
                              musics: libraryInstance.rockMusic,
                              onTap: (music) {
                                GoRouter.of(
                                  context,
                                ).go('/musics/all/music/${music.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'music/:musicId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MusicDetailsScreen(
                            music: libraryInstance.getMusic(
                              state.pathParameters['musicId'] ?? '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/musics/pop',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return MusicList(
                              musics: libraryInstance.popMusic,
                              onTap: (music) {
                                GoRouter.of(
                                  context,
                                ).go('/musics/all/music/${music.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'music/:musicId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MusicDetailsScreen(
                            music: libraryInstance.getMusic(
                              state.pathParameters['musicId'] ?? '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/musics/jazz',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return MusicList(
                              musics: libraryInstance.jazzMusic,
                              onTap: (music) {
                                GoRouter.of(
                                  context,
                                ).go('/musics/all/music/${music.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'music/:musicId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MusicDetailsScreen(
                            music: libraryInstance.getMusic(
                              state.pathParameters['musicId'] ?? '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  GoRoute(
                    path: '/musics/all',
                    pageBuilder: (context, state) {
                      return FadeTransitionPage<dynamic>(
                        key: state.pageKey,
                        child: Builder(
                          builder: (context) {
                            return MusicList(
                              musics: libraryInstance.allMusic,
                              onTap: (music) {
                                GoRouter.of(
                                  context,
                                ).go('/musics/all/music/${music.id}');
                              },
                            );
                          },
                        ),
                      );
                    },
                    routes: [
                      GoRoute(
                        path: 'music/:musicId',
                        parentNavigatorKey: appShellNavigatorKey,
                        builder: (context, state) {
                          return MusicDetailsScreen(
                            music: libraryInstance.getMusic(
                              state.pathParameters['musicId'] ?? '',
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
              GoRoute(
                path: '/artists',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: Builder(
                      builder: (context) {
                        return ArtistsScreen(
                          onTap: (artist) {
                            GoRouter.of(
                              context,
                            ).go('/artists/artist/${artist.id}');
                          },
                        );
                      },
                    ),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'artist/:artistId',
                    builder: (context, state) {
                      final artist = libraryInstance.allArtists.firstWhere(
                        (artist) =>
                            artist.id ==
                            int.parse(state.pathParameters['artistId']!),
                      );
                      return Builder(
                        builder: (context) {
                          return ArtistDetailsScreen(
                            artist: artist,
                            onMusicTapped: (music) {
                              GoRouter.of(
                                context,
                              ).go('/musics/all/music/${music.id}');
                            },
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: '/settings',
                pageBuilder: (context, state) {
                  return FadeTransitionPage<dynamic>(
                    key: state.pageKey,
                    child: const AboutScreen(),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
