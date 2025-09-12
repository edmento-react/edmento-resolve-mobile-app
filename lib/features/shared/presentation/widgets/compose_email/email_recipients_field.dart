import 'package:edmentoresolve/core/di/injection_container.dart';
import 'package:edmentoresolve/features/shared/data/services/users_cache_service.dart';
import 'package:edmentoresolve/features/shared/domain/entities/person.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmailRecipientsField extends StatefulWidget {
  final String label;
  final List<Person> selectedRecipients;
  final ValueChanged<List<Person>> onRecipientsChanged;
  final bool isRequired;
  final bool isReadOnly;

  const EmailRecipientsField({
    super.key,
    required this.label,
    required this.selectedRecipients,
    required this.onRecipientsChanged,
    this.isRequired = false,
    this.isReadOnly = false,
  });

  @override
  State<EmailRecipientsField> createState() => _EmailRecipientsFieldState();
}

class _EmailRecipientsFieldState extends State<EmailRecipientsField> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isSearching = false;
  List<Person> _searchResults = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _onFocusChanged() {
    setState(() {
      _isSearching = _focusNode.hasFocus;
    });
    if (_isSearching) {
      _performSearch(_searchController.text);
    }
  }

  void _performSearch(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      print('🔍 EmailRecipientsField: Searching for "$query"');

      // Get users from cache service
      final usersCacheService = sl<UsersCacheService>();

      if (!usersCacheService.hasValidCache) {
        print('⚠️ EmailRecipientsField: No cached users available');
        setState(() {
          _searchResults = [];
          _isLoading = false;
        });
        return;
      }

      // Search users in cache
      final searchResults = usersCacheService.searchUsers(query);

      print(
        '🔍 EmailRecipientsField: Found ${searchResults.length} matching users in cache',
      );

      // Filter out already selected recipients
      final filteredResults = searchResults
          .where(
            (person) => !widget.selectedRecipients.any(
              (selected) => selected.id == person.id,
            ),
          )
          .toList();

      print(
        '📋 EmailRecipientsField: After filtering selected recipients: ${filteredResults.length} people',
      );

      setState(() {
        _searchResults = filteredResults;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ EmailRecipientsField: Error occurred: $e');
      setState(() {
        _searchResults = [];
        _isLoading = false;
      });
    }
  }

  void _selectPerson(Person person) {
    final updatedRecipients = List<Person>.from(widget.selectedRecipients)
      ..add(person);
    widget.onRecipientsChanged(updatedRecipients);
    _searchController.clear();
    _performSearch('');
  }

  void _removePerson(Person person) {
    final updatedRecipients = widget.selectedRecipients
        .where((p) => p.id != person.id)
        .toList();
    widget.onRecipientsChanged(updatedRecipients);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[300]!, width: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 50.w,
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _searchController,
                  focusNode: _focusNode,
                  enabled: !widget.isReadOnly,
                  decoration: InputDecoration(
                    hintText: widget.isRequired
                        ? 'Search and select recipients...'
                        : 'Optional recipients...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                    hintStyle: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.grey[400],
                    ),
                  ),
                  style: TextStyle(fontSize: 14.sp, color: Colors.black87),
                  onChanged: _performSearch,
                  textInputAction: TextInputAction.done,
                ),
              ),
            ],
          ),

          // Selected recipients chips
          if (widget.selectedRecipients.isNotEmpty) ...[
            SizedBox(height: 8.h),
            Wrap(
              spacing: 8.w,
              runSpacing: 4.h,
              children: widget.selectedRecipients.map((person) {
                return Chip(
                  label: Text(person.name, style: TextStyle(fontSize: 12.sp)),
                  deleteIcon: Icon(Icons.close, size: 16.w),
                  onDeleted: widget.isReadOnly
                      ? null
                      : () => _removePerson(person),
                  backgroundColor: Colors.blue[50],
                  labelStyle: TextStyle(color: Colors.blue[700]),
                );
              }).toList(),
            ),
          ],

          // Search results dropdown
          // Search results dropdown
          if (_isSearching) ...[
            SizedBox(height: 8.h),
            if (_searchController.text.isNotEmpty)
              Container(
                constraints: BoxConstraints(
                  maxHeight: !_isLoading && _searchResults.isNotEmpty
                      ? 200.h
                      : _isLoading
                      ? 150.h
                      : 100.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: _isLoading
                    // 👉 Skeleton loader
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: 4,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: CircleAvatar(
                              radius: 16.r,
                              backgroundColor: Colors.grey[300],
                            ),
                            title: Container(
                              height: 14.h,
                              color: Colors.grey[300],
                              margin: EdgeInsets.symmetric(vertical: 4.h),
                            ),
                            subtitle: Container(
                              height: 12.h,
                              color: Colors.grey[200],
                              margin: EdgeInsets.only(top: 4.h),
                            ),
                          );
                        },
                      )
                    // 👉 Results list
                    : _searchResults.isNotEmpty
                    ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _searchResults.length,
                        itemBuilder: (context, index) {
                          final person = _searchResults[index];
                          return ListTile(
                            dense: true,
                            leading: CircleAvatar(
                              radius: 16.r,
                              backgroundColor: Colors.blue[100],
                              child: Text(
                                person.name.isNotEmpty
                                    ? person.name[0].toUpperCase()
                                    : '?',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue[700],
                                ),
                              ),
                            ),
                            title: Text(
                              person.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(
                              '${person.assignedRoles?.map((role) => role.positionName).join(', ')} • ${person.email}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                            onTap: () => _selectPerson(person),
                          );
                        },
                      )
                    // 👉 Empty state
                    : Center(
                        child: Text(
                          "No results found",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
              ),
          ],
        ],
      ),
    );
  }
}
